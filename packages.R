# packages.R
# Installe tous les packages nécessaires pour compiler le livre.
# Lance ce script une seule fois après avoir cloné le dépôt.
#
# Dans RStudio : ouvre ce fichier et clique sur "Source"

install.packages(c(
  "spatstat",   # Processus ponctuels spatiaux
  "ggplot2",    # Visualisation
  "knitr",      # Intégration R/Quarto
  "rmarkdown"   # Rendu de documents
))
