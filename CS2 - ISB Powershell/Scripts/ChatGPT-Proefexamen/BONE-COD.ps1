# Name: BONE-CoD.ps1
# Author: Younes El Azzouzi
# Date: 06/06/2025

<#
.SYNOPSIS
    Analyseert gegevens van Call of Duty games op basis van een CSV-bestand.

.DESCRIPTION
    Dit script bevat functies die een lijst van CoD games analyseren:
    - Filtering op Metacritic-score
    - Gemiddelde beoordeling per generatie
    - Top games op basis van gebruikersscore
    - Tellen van games per platform
    - Oplijsten van unieke ontwikkelaars
    - Wegschrijven van gefilterde data

.EXAMPLE
    .\BONE-CoD.ps1
#>

$path = "./cod_games.csv"

if (!(Test-Path $path)) {
    Write-Host "Bestand $path NIET gevonden!" -ForegroundColor Red
    exit 1 
}

$cod = Import-Csv -Delimiter ";" $path

if ($cod.Count -eq 0) {
    Write-Host "Je hebt een leeg bestand geïmporteerd!" -ForegroundColor Red
    exit 1
}

# 1. Filter games met metascore >= grens
function Filter-Metacritic ($cod, $grens) {
    # TODO: Filter games met metascore groter of gelijk aan grens
    return $cod | Where-Object { [double]$_.UserScore -ge $grens }
}

# 2. Gemiddelde user score per generatie
function Avg-UserScoreByGen ($cod) {
    # TODO: Group per generatie en bereken gemiddelde UserScore
    return $cod | Group-Object Generation | ForEach-Object {
        [PSCustomObject]@{
            Name = $_.Name
            AVGUserScore = ($($_.Group | Measure-Object -Property UserScore -Average)).Average
        }
    }
}

# 3. Top 3 games volgens UserScore
function Top-Games ($cod) {
    # TODO: Sorteer op UserScore descending en toon top 3
    return $cod | Sort-Object -Property UserScore -Descending | Select-Object -First 3
}

# 4. Aantal games per platform
function Count-ByPlatform ($cod) {
    # TODO: Groepeer per platform en tel het aantal games
    return $cod | Group-Object Platform | ForEach-Object {
        [PSCustomObject]@{
            Name = $_.Name
            Count = $_.Count
        }
    }
}

# 5. Unieke ontwikkelaars oplijsten
function Get-Developers ($cod) {
    # TODO: Toon unieke waarden in kolom Developer
    return $cod | Select-Object -ExpandProperty Publisher | Sort-Object -Unique
}

# 6. Exporteer alle games van een platform
function Export-PlatformGames ($cod, $platform) {
    # TODO: Filter op platform en exporteer naar CSV
    $filtered = $cod | Where-Object { $_.Platform -eq $platform }
    $filtered | Select-Object Title, Publisher, Platform | Export-Csv -Path "PSCODS.csv" -NoTypeInformation -Delimiter ";"
}

# ======================
# Hoofdprogramma
# ======================

$grens = 8.0
$targetPlatform = "PlayStation"

Filter-Metacritic $cod $grens | Format-Table
Avg-UserScoreByGen $cod | Format-Table
Top-Games $cod | Format-Table
Count-ByPlatform $cod | Format-Table
Get-Developers $cod | Format-Table
Export-PlatformGames $cod $targetPlatform | Format-Table