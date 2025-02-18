# AUTEUR  : Thomas ZIMMER.
# Date    : 12/11/2021
# Comment : Le script va rechercher à partir d'un chemin donné tous les dossiers pouvant contenir "*old*, *anci*, *archi*", 
#           les afficher puis calculer le total de leurs tailles en "MO".

$ErrorActionPreference = 'Stop' # Affichage des erreurs détaillées au cas où

# Fonction pour calculer la taille d'un répertoire
function Get-FolderSize {
    param (
        [string]$folderPath
    )
    # Calcul de la taille totale d'un dossier
    $size = (Get-ChildItem -Path $folderPath -Recurse -Force | Measure-Object -Property Length -Sum).Sum
    # Convertir la taille en Mo et arrondir à 2 décimales
    return [math]::Round($size / 1MB, 2)
}

# Fonction pour rechercher des dossiers spécifiques
function Search-Folders {
    param (
        [string]$searchPath,
        [string[]]$searchPatterns
    )
    # Recherche des dossiers correspondant aux critères
    $foundFolders = @()
    foreach ($pattern in $searchPatterns) {
        $foundFolders += Get-ChildItem -Path $searchPath -Recurse -Directory -Include $pattern -Force
    }
    return $foundFolders
}

# Demande du chemin où effectuer la recherche
$chemin = Read-Host "Chemin où effectuer la recherche"

# Liste des motifs de recherche
$objlst = "*old*", "*anci*", "*archi*"

# Initialisation de la variable pour stocker la taille totale
$TailleTotale = 0

# Recherche des dossiers correspondants
$foundFolders = Search-Folders -searchPath $chemin -searchPatterns $objlst

# Affichage des résultats et calcul de la taille totale
foreach ($folder in $foundFolders) {
    $taille = Get-FolderSize -folderPath $folder.FullName
    Write-Output "Répertoire : $($folder.FullName), Taille : $taille Mo"
    $TailleTotale += $taille
}

# Affichage de la taille totale
Write-Output " "
Write-Output "Taille totale : $TailleTotale Mo"

# Option d'export des résultats
$exportOption = Read-Host "Souhaitez-vous exporter les résultats sous forme de fichier CSV ? (Oui/Non)"
if ($exportOption -eq "Oui") {
    $results = $foundFolders | Select-Object FullName, @{Name="Taille (Mo)";Expression={Get-FolderSize -folderPath $_.FullName}}
    $results | Export-Csv -Path "resultats_archives.csv" -NoTypeInformation -Delimiter ";" -Encoding UTF8
    Write-Output "Les résultats ont été exportés vers 'resultats_archives.csv'."
}

Pause
