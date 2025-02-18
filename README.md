# Analyse des Dossiers d'Archivage

## Description
Le script PowerShell permet de rechercher des dossiers contenant des motifs spécifiques dans leur nom (tels que "*old*", "*anci*", "*archi*") à partir d'un chemin donné. Il affiche ensuite la taille de ces dossiers en Mo et calcule la taille totale de l'ensemble des dossiers trouvés.

### Fonctionnalités principales :
- Recherche des dossiers contenant les termes spécifiés dans leur nom.
- Calcul de la taille de chaque dossier en Mo.
- Calcul de la taille totale des dossiers trouvés.
- Option d'exportation des résultats sous forme de fichier CSV.

## Prérequis
- PowerShell doit être installé sur le système.
- L'utilisateur doit avoir les autorisations nécessaires pour accéder aux répertoires spécifiés.

## Installation
1. Téléchargez ou copiez le script PowerShell `Recherche_archives.ps1` sur votre machine.
2. Ouvrez PowerShell et exécutez le script en utilisant la commande :
   ```powershell
   .\searchArchives.ps1
