# TennisAnalyse.ps1

$path = "./tennis.csv"

if (!(Test-Path $path)) {
    Write-Host "Bestand is NIET gevonden!" -ForegroundColor Red
    exit 1 
}

$data = Import-Csv -Delimiter ";" $path

if ($data.Count -eq 0) {
    Write-Host "Je hebt een leeg bestand geimporteerd!" -ForegroundColor Red
    exit 1
}

# 1. Tel totaal aantal gewonnen sets per speler
function Total-TennisSets {
    param ([array]$tennis)

    # TODO: voeg winnersets en losersets per speler samen
    $alleSpelers = foreach ($match in $tennis){
        [PSCustomObject]@{
            Naam = $match.winner
            Sets = [int]$match.winnersets
        }
        [PSCustomObject]@{
            Naam = $match.loser
            Sets = [int]$match.losersets
        }
    }

    $alleSpelers | Group-Object Naam | ForEach-Object {
        [PSCustomObject]@{
            Speler = $_.Name
            Totaalsets = ($_.Group | Measure-Object -Property Sets -Sum).Sum
        }
    } | Sort-Object Totaalsets -Descending
}

# 2. Toon alle matchen van een opgegeven speler
function Show-TennisMatches {
    param ([array]$tennis)

    $naam = Read-Host "Geef spelernaam"

    $tennis | Where-Object {
        $_.winner -like "*$naam*" -or $_.loser -like "*$naam*"
    } | Format-Table tourney, round, winner, loser, winnersets, losersets
}


# 3. Toon speler met meeste overwinningen
function Get-TopWinner {
    param ([array]$tennis)

    # TODO: Group-Object op winner en sorteer op Count
    $alleSpelers = foreach ($match in $tennis){
        [PSCustomObject]@{
            Naam = $match.winner
        }
    }

    $alleSpelers | Group-Object -Property Naam | Sort-Object -Property Count -Descending | Select-Object -First 1 | ForEach-Object {
        [PSCustomObject]@{
            Speler = $_.Name
            Overwinningen = $_.Count
        }
    }
}

# Aanroepen
Total-TennisSets -tennis $data
Show-TennisMatches -tennis $data
Get-TopWinner -tennis $data
