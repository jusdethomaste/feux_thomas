# Modélisation spatiale des feux de forêt

Dépôt du projet de modélisation probabiliste des feux de forêt.  
Superviseur : [Ton nom] — [Institution]

---

## Démarrage rapide

### 1. Cloner le dépôt

```bash
git clone https://github.com/TON-USERNAME/feux-foret-book.git
cd feux-foret-book
```

### 2. Installer les packages R

Ouvre `packages.R` dans RStudio et clique sur **Source**, ou lance dans la console R :

```r
source("packages.R")
```

### 3. Compiler le livre localement

Dans RStudio, ouvre le fichier `_quarto.yml` puis clique sur **Render Book** (en haut de l'éditeur), ou dans le terminal :

```bash
quarto render
```

Le livre s'ouvre automatiquement dans ton navigateur.

---

## Mettre à jour ton travail

Après chaque session de travail :

```bash
git add .
git commit -m "Description courte de ce que tu as fait"
git push
```

Le livre est automatiquement recompilé et publié en ligne via GitHub Actions (quelques minutes après le push).

---

## Structure du projet

```
feux-foret-book/
├── _quarto.yml            # Configuration du livre
├── index.qmd              # Préface
├── 01-introduction.qmd    # Chapitre 1
├── 02-methodologie.qmd    # Chapitre 2
├── 03-simulations.qmd     # Chapitre 3
├── 04-resultats.qmd       # Chapitre 4
├── 05-discussion.qmd      # Chapitre 5
├── references.qmd         # Références
├── references.bib         # Base de données bibliographique
├── figures/               # Images et captures d'écran
├── packages.R             # Script d'installation des packages
└── .github/workflows/     # Publication automatique
    └── publish.yml
```

### Ajouter une image

Place ton fichier image dans le dossier `figures/` et insère-la dans un `.qmd` :

```markdown
![Description de la figure](figures/nom_image.png){fig-align="center" width="80%"}
```

### Ajouter une référence

Ajoute l'entrée BibTeX dans `references.bib`, puis cite avec `@cle` dans le texte.  
Dans RStudio, tu peux aussi utiliser **Insert → Citation** (via DOI).
