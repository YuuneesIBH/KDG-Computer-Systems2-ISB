# Name: Score-Tennis.ps1
# Author: Laura Borghijs
# Date: 07/06/2024

<#
.SYNOPSIS
    Verschillende functies die data van tennistornooien analyseren.

.NOTES


.EXAMPLE
    .\Score-Tennis.ps1 
#>


# Vul hieronder aan, maar houd de structuur van de functies

Param(
    [string]$csvfile= ".\tennis.csv" 
)


try {
    $matches = Import-Csv $csvfile -Delimiter ";"
} catch {
    Write-Host "Er is iets fout gelopen met het inlezen van de csv file"
    exit
}

function Get-Tourneys ($matches) {
    [array] $copiedMatches = $null

    foreach ($match in $matches){
        $copiedMatches+=$match
    }

  return $copiedMatches 
  }


function Get-Winners ($matches) {
    [array] $winners = $null

    foreach ($match in $matches){
    if ($match.round -like "Finals"){
        $winners+=$match
    }
  }

  return $winners| Select-Object -Property "tourney","winner"
  }


function Get-Matches {
 param (
        [Array]$matches,
        [String]$player,
        [String]$tourney
    )
    [array]$matchesFrom = $null

    foreach ($match in $matches){
    if ($match.tourney -like $tourney ){
        if($match.winner -like $player -or $match.loser -like $player) {
            $matchesFrom+=$match
        } else {
            if(($match.tourney -like "*") -and $match.winner -like "*Nadal" -or $match.loser -like "*Nadal"){
            $matchesFrom+=$match
           }
        }
    }
  }

  return $matchesFrom 
  }



function Get-BigMatches ($matches, $player) {
    [array]$bigMatches = $null

    foreach ($match in $matches){
        if($match.winnersets -eq 3 -and $match.winner -like $player) {
            $bigMatches+=$match
        } else {
            if($match.winnersets -eq 3 -and $match.winner -like "*Nadal"){
            $bigMatches+=$match
           }
        }
  }
    return $bigMatches
  }


function Get-BigTourney ($matches) {
    [array]$bigTourneys = $null

    foreach ($match in $matches){
       if($match.winnersets -eq 3 -and $match.round -like "Finals") {
           $bigTourneys+=$match
       } 
  }
  return $bigTourneys | Select-Object -Property tourney -Unique | Sort-Object -Property tourney
  }


function Get-Players ($matches) {
    [array]$players = $null

    foreach ($match in $matches){
        $players+=$match
    } 

    return $players | Select-Object -Property loser -Unique | Sort-Object -Property loser
  }


function Get-PlayerScore ($matches, $player) {
   [int]$score = 0

   foreach ($match in $matches){
        if($match.winner -like $player) {
            $score = [int]$match.winnersets - [int]$match.losersets
        } elseif($match.loser -like $player) {
            $score = [int]$match.losersets - [int]$match.winnersets
        }
    } 

  return $score
  }


function Get-Score ($matches) {
    foreach ($match in $matches){
        $scores = [PSCustomObject]@{
            [string]$player = Get-Players($matches)
            [int]$score = Get-PlayerScore($matches, $player)
        }
    }

  return $scores
  }


function Print-Score ($matches) {
   
  Write-Host 
    
  }


# Hoofdprogramma: hier niks wijzigen
# Linux: vervang alle Out-GridView door Format-Table
# Haal de lijnen uit commentaar voor de functies die werken
# Voor functies die niet werken: laat deze in commentaar staan
# Zo lever je een werkend script af

$tourney = "miami"
$player = "*Nadal"


Get-Tourneys $matches | Out-GridView
Get-Winners $matches | Out-GridView 
Get-Matches $matches $player $tourney | Out-GridView
Get-BigMatches $matches $player | Out-GridView
Get-BigTourney $matches | Out-GridView
Get-Players $matches | Out-GridView 
Get-PlayerScore $matches $player
Get-Score $matches | Out-GridView
#Print-Score $matches

