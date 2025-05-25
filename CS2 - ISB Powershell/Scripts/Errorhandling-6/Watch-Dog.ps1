<#
.SYNOPSIS
Controleert of een programma draait, en start het opnieuw als die niet draai.

.DESCRIPTION
Voert een oneindige loop uit die controleert of een programma loopt. Als dat niet zo is, wordt die opnieuw opgestart.

.EXAMPLE
./Watch-Dog.ps1 notepad
#>

param (
    [string]$program,
    [switch]$help
)

if ($help) {
    Write-Output "Gebruik: ./Watch-Dog.ps1 -program <programmanaam>"
    exit
}

while ($true) {
    $proc = Get-Process -Name $program -ErrorAction SilentlyContinue
    if (-not $proc){
        Start-Process $program
    } 

    Start-Sleep -Seconds 2
}