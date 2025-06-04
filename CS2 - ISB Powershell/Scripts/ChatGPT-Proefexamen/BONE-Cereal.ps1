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
    Auteur: Younes El Azzouzi
    Examen BONE-stijl – Computersystemen 2
    Systeem: getest op VS Code met PowerShell op macOS
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
    #CASTEN IS NODIG!!!!
    return $cereal | Where-Object {
        [int]$_.calories -le $max
    } | Sort-Object calories -Descending
}

# 2. Gemiddelde suiker per type
function Avg-SugarByType ($cereal) {
    # TODO: Group op type en bereken gemiddelde suiker
    return $cereal | Group-Object type | ForEach-Object {
        [PSCustomObject]@{
            Type = $_.Name
            AVGSugars = ($_.Group | Measure-Object -Property sugars -Average).Average
        }
    }
}

# 3. Geef top 3 granen met meeste vezels
function Top-Fiber ($cereal) {
    # TODO: Sorteer op fiber descending en toon top 3
    return $cereal | Sort-Object -Property fiber -Descending | Select-Object -First 3
}

# 4. Tel het aantal producten per type
function Count-ByType ($cereal) {
    # TODO: Group-Object op type en tel aantal
    return $cereal | Group-Object type | ForEach-Object {
        [PSCustomObject]@{
            Type = $_.Name
            Count = $_.Count
        }
    }
}

# 5. Bereken gemiddelde calorieën per type
function Avg-CalorieByType ($cereal) {
    # TODO: Group op type en bereken gemiddelde calorieën
    return $cereal | Group-Object type | ForEach-Object {
        [PSCustomObject]@{
            Type = $_.Name
            GemCalls = ($_.Group | Measure-Object -Property calories -Average).Average
        }
    }
}

# 6. Geef product(en) met minst suiker
function Min-Sugar ($cereal) {
    # TODO: Sorteer op sugars ascending en selecteer laagste(n)
    return $cereal | Sort-Object -Property sugars | Select-Object -First 3
}

# ===================================
# Hoofdprogramma: hier niks wijzigen
# Linux: vervang alle Out-GridView door Format-Table
# Haal de lijnen uit commentaar voor de functies die werken
# Voor functies die niet werken: laat deze in commentaar staan
# Zo lever je een werkend script af
# ===================================

$maxCal = 100

Filter-Calorie $cereal $maxCal | Format-Table
Avg-SugarByType $cereal | Format-Table
Top-Fiber $cereal | Format-Table
Count-ByType $cereal | Format-Table
Avg-CalorieByType $cereal | Format-Table
Min-Sugar $cereal | Format-Table