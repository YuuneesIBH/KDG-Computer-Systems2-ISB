# Name: Get-Mac.ps1
# Author:
# Date:

$filename = "....\MacTable.csv"

function Delete-LinesCsv($property, $value, $filename) {
    Import-Csv $filename | ? { $_.... } | Export-Csv ($filename + ".new") -force
    Move-Item ....
    }

function Write-Mac() {
    ....
    }

function Get-Mac($computername) {
    ....
    }

function Clean-Mac([int]$maxtimespan) {
    ....
    }

# Hoofdprogramma
....
