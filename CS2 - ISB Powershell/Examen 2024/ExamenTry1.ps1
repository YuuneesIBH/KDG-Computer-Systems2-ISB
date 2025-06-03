# Score-Tennis.ps1

<#
.SYNOPSIS
    Verschillende functies van tennisdata bekijken.

.NOTES

.EXAMPLE
    .\ExamenTry.ps1
#>

# Laad de CSV in
# Definieer pad (altijd veilig, cross-platform)
$filename = "./tennis.csv"

# Check of het bestand bestaat
if (!(Test-Path $filename)) {
    Write-Host "Kon het bestand niet vinden op pad $filename" -ForegroundColor Red
    exit 1
}

# Pas dan inlezen!
$tennisData = Import-Csv -Delimiter ";" $filename


# Functie: Bereken totaal aantal gewonnen sets per speler
function Total-Score {
    param (
        [array]$tennisData
    )

    # HashTable om sets per speler bij te houden
    $setsPerSpeler = @{}

    foreach ($match in $tennisData) {
        $winner = $match.winner
        $loser = $match.loser
        $winnerSets = [int]$match.winnersets
        $loserSets = [int]$match.losersets

        # Voeg sets toe aan winnaar
        if (-not $setsPerSpeler.ContainsKey($winner)) {
            $setsPerSpeler[$winner] = 0
        }
        $setsPerSpeler[$winner] += $winnerSets

        # Voeg sets toe aan verliezer
        if (-not $setsPerSpeler.ContainsKey($loser)) {
            $setsPerSpeler[$loser] = 0
        }
        $setsPerSpeler[$loser] += $loserSets
    }

    # Toon alle spelers en hun totaalscore
    foreach ($speler in $setsPerSpeler.Keys) {
        Write-Host "$speler : $($setsPerSpeler[$speler]) gewonnen sets" -ForegroundColor Yellow
    }
}


# Functie: Toon spelers die minstens 2 keer een match wonnen
# Functie: Toon spelers die minstens 2 keer een 6 haalden
function Get-Winnaars {
    param (
        [array]$tennisData
    )

    $groepen = $tennisData | Group-Object -Property winner

    foreach ($groep in $groepen) {
        if ($groep.Count -ge 2) {
            Write-Host "$($groep.Name) heeft minstens 2 keer gewonnen"
        }
    }
}


# Functie: Toon speler met hoogste totaalscore
function Get-BesteSpeler {
    param (
        [array]$tennisData
    )

    $tennisData |
        Group-Object -Property winner |
        Sort-Object Count -Descending |
        Select-Object -First 1 |
        ForEach-Object {
            Write-Host "Beste speler is $($_.Name) met $($_.Count) gewonnen match(es)." -ForegroundColor Cyan
        }
}

# Functie: Vraag spelernaam op en toon scores
function Show-SpelerScores {
    param (
        [array]$tennisData
    )

    $naam = Read-Host "Geef naam van de speler"
    Write-Host "`nWedstrijden van: $naam`n" -ForegroundColor Cyan

    $tennisData |
        Where-Object { $_.winner -ieq $naam -or $_.loser -ieq $naam } |
        Where-Object { $_.winnersets -ne $_.losersets } |
        ForEach-Object {
            $rol = if ($_.winner -ieq $naam) { "Win" } else { "Loss" }
            $tegen = if ($rol -eq "Win") { $_.loser } else { $_.winner }
            $sets = if ($rol -eq "Win") { "$($_.winnersets)-$($_.losersets)" } else { "$($_.losersets)-$($_.winnersets)" }
            Write-Host "$rol vs $tegen in $($_.round): $sets"
        }
}

# Functie: Schrijf totaalscores weg naar een CSV
function Save-TotalScores {
    param (
        [array]$tennisData
    )

    $scores = @{}

    foreach ($match in $tennisData) {
        $winner = $match.winner
        $sets = [int]$match.winnersets

        if (-not $scores.ContainsKey($winner)) {
            $scores[$winner] = 0
        }

        $scores[$winner] += $sets
    }

    $scores.GetEnumerator() | ForEach-Object {
        [PSCustomObject]@{
            Speler = $_.Key
            TotaalGewonnenSets = $_.Value
        }
    } | Export-Csv -Path "TotalScores.csv" -NoTypeInformation -Force

    Write-Host "TotalScores.csv aangemaakt." -ForegroundColor Green
}

# Functie-aanroepen
Total-Score -tennisData $tennisData
Get-Winnaars -tennisData $tennisData
Get-BesteSpeler -tennisData $tennisData
Show-SpelerScores -tennisData $tennisData
Save-TotalScores -tennisData $tennisData