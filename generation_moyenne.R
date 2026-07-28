

library(sf)
library(tidyverse)
library(lubridate)

# 1. Lecture locale (Ajustez le chemin selon votre dossier)
chemin_fichier_shp <- "C:/École/E26/STT-4700/feux-foret-book/donnees_brutes/fire_archive_SV-C2_779088.shx"
hotspots_qc <- st_read(chemin_fichier_shp)

# 2. Traitement des données
coordonnees <- st_coordinates(hotspots_qc)
donnees_tables <- hotspots_qc %>%
  st_drop_geometry() %>% 
  mutate(
    longitude = coordonnees[, "X"],
    latitude  = coordonnees[, "Y"],
    date_complete = as.Date(ACQ_DATE), 
    annee = year(date_complete),
    jour_annee = yday(date_complete)
  )

# 3. Filtrage Nord du Québec et calcul des moyennes
calendrier_moyen <- expand_grid(annee = 2016:2026, jour_annee = 1:366) %>%
  filter(!(jour_annee == 366 & !leap_year(annee))) %>%
  left_join(
    donnees_tables %>%
      filter(latitude >= 49.0 & annee %in% 2016:2026) %>%
      group_by(annee, jour_annee) %>%
      summarise(total_feux_du_jour = n(), .groups = "drop"),
    by = c("annee", "jour_annee")
  ) %>%
  mutate(total_feux_du_jour = replace_na(total_feux_du_jour, 0)) %>%
  group_by(jour_annee) %>%
  summarise(moyenne_feux = mean(total_feux_du_jour), .groups = "drop") %>%
  mutate(date_affichage = as.Date(jour_annee - 1, origin = "2026-01-01"))

# 4. Création du graphique ggplot
p_saison <- ggplot(calendrier_moyen, aes(x = date_affichage, y = moyenne_feux)) +
  geom_line(colour = "darkblue", alpha = 0.4) +
  geom_smooth(span = 0.15, colour = "darkred", se = FALSE, linewidth = 1.2) +
  scale_x_date(date_breaks = "1 month", date_labels = "%B") +
  labs(
    title = "Nombre quotidien d'incendies (10 dernières années)",
    subtitle = "Nord du Québec | Données NASA ",
    x = "Mois", y = "Nombre moyen de foyers détectés par jour"
  ) +
  theme_minimal()

# 5. SAUVEGARDE AUTOMATIQUE POUR QUARTO / GITHUB
# Assurez-vous que le dossier "images" existe avant de lancer cette ligne
ggsave("C:/École/E26/STT-4700/feux-foret-book/images/saison_feux_qc.png", plot = p_saison, width = 8, height = 5, dpi = 150)

# Optionnel : Sauvegarder les résultats légers en CSV pour pouvoir les réutiliser sans recalculer
write_csv(calendrier_moyen, "images/calendrier_moyen_nord_qc.csv")
