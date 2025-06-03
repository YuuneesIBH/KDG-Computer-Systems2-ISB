# Name:BONE-Cereal.ps1
# Author: Younes El Azzouzi
# Date: 05/06/2025


<#
.SYNOPSIS
    Analyseert gegevens van ontbijtgranen op basis van een CSV-bestand.

.DESCRIPTION
    Dit script bevat verschillende functies om data uit cereal.csv te verwerken:
    - Filteren op calorieën
    - Gemiddelde suiker en calorieën per type
    - Top vezelrijke granen
    - Aantal producten per type
    - Granen met de minste suiker

    De gebruiker hoeft enkel de juiste lijnen in het hoofdprogramma te activeren.
    Werkt op macOS/Linux met Format-Table i.p.v. Out-GridView.

.EXAMPLE
    .\BONE-Cereal.ps1

.NOTES
    Voor gebruik in examen BONE-stijl. Gebruik Format-Table als output.
#>

$path = "./cereal.csv"

if (!(Test-Path $path)) {
    Write-Host "Bestand is NIET gevonden!" -ForegroundColor Red
    exit 1 
}

$cereal = Import-Csv -Delimiter ";" $path

if ($cereal.Count -eq 0) {
    Write-Host "Je hebt een leeg bestand geimporteerd!" -ForegroundColor Red
    exit 1
}

# 1. Filter op max aantal calorieën
function Filter-Calorie ($cereal, $max) {
    # TODO: Filter granen met calories ≤ max
}

# 2. Gemiddelde suiker per type
function Avg-SugarByType ($cereal) {
    # TODO: Group op type en bereken gemiddelde suiker
}

# 3. Geef top 3 granen met meeste vezels
function Top-Fiber ($cereal) {
    # TODO: Sorteer op fiber descending en toon top 3
}

# 4. Tel het aantal producten per type
function Count-ByType ($cereal) {
    # TODO: Group-Object op type en tel aantal
}

# 5. Bereken gemiddelde calorieën per type
function Avg-CalorieByType ($cereal) {
    # TODO: Group op type en bereken gemiddelde calorieën
}

# 6. Geef product(en) met minst suiker
function Min-Sugar ($cereal) {
    # TODO: Sorteer op sugars ascending en selecteer laagste(n)
}

# ===================================
# Hoofdprogramma: hier niks wijzigen
# Linux: vervang alle Out-GridView door Format-Table
# Haal de lijnen uit commentaar voor de functies die werken
# Voor functies die niet werken: laat deze in commentaar staan
# Zo lever je een werkend script af
# ===================================

$maxCal = 100

#Filter-Calorie $cereal $maxCal | Format-Table
#Avg-SugarByType $cereal | Format-Table
#Top-Fiber $cereal | Format-Table
#Count-ByType $cereal | Format-Table
#Avg-CalorieByType $cereal | Format-Table
#Min-Sugar $cereal | Format-Table