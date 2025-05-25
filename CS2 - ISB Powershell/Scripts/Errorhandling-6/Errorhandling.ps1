#in dit deeltje gaan we dieper in de leerstof over errorhandling.
#ik begin eerst met een ping naar de localhost
ping localhost

#daarna kan ik met $? kijken of het vorige commando succesvol was.
$?

#deze geef False omdat ik CTLR C maar als ik die laat lopen krijg ik True
#nadien probeer ik te pignen naar een host die niet bestaat
ping nonexistinghost

$?

#ik ga nu proberen het process notepad op te halen zonder dat het process draait
Get-Process notepad

#Get-Process : Cannot find a process with the name "notepad". Verify the process name and call the cmdlet again.
#At line:1 char:1
#+ Get-Process notepad
#+ ~~~~~~~~~~~~~~~~~~~
#    + CategoryInfo          : ObjectNotFound: (notepad:String) [Get-Process], ProcessCommandException
#    + FullyQualifiedErrorId : NoProcessFoundForGivenName,Microsoft.PowerShell.Commands.GetProcessCommand

#nu kunnen we deze fout onderdrukken door 
Get-Process notepad -ErrorAction SilentlyContinue

$? #omdat notepad niet draaide krijg ik hier false

#Nu kan ik ook erroractions instellen voor een volledig script.
$ErrorActionPreference = 'SilentlyContinue'

#Hieronder een voorbeeld van een try - catch met expliciete foutafhandeling
try {
    $c = Get-Content -Path C:\nietbestaand.txt -ErrorAction Stop 
} catch {
    Write-Host "File does not exist" - Foregroundcolor -Red
    exit 1 # kan gecontroleerd worden met $?
}

#Nu gaan we een kijken naar hoe dat we documentatie kunnen toevoegen aan een bestand. Je kan documentatie op deze manier implementeren:

<#
.SYNOPSIS
Maakt de som van twee getallen

.DESCRIPTION
Drukt de som af van 2 getallen die als paramter gegeven worden. 

.EXAMPLE
PS> Maak-Som 3 4 
3 + 4 = 7
#>

#hieronder maak ik het effectieve script (logica):
if ($args.count -ne 2) {
	Write-Output "Gebruik: Maak-Som.ps1 getal1 getal2"
} else {
	Write-Output ($args[0] + $args[1])
}

#als ik dit hier opsla als Maak-Som.ps1 kan ik de documentatie zo aanroepen:
Get-Help ./Maak-Som.ps1
./Maak-Som.ps1 5 9

#Nu ga ik een script maken dat gaat kijken of een programma draait. Zoniet gaat die die opstarten. 
#Ik add een documentatie en --help 

notepad Watch-Dog.ps1
#met de inhoud:

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

#testing met 
./Watch-Dog.ps1 -help
./Watch-Dog.ps1 -program notepad

#We maken nu een script dat aan de gebruiker vraagt naar getallen.
#Stel die voert een string of een negatief getal is gaan we die errors correct opvangen. 
#Fibonacci is een reeks waarbij elk nieuw getal de som is van de twee vorige

notepad Get-Fibo1.ps1

try {
    $n = Read-Host "Geef een aantal getallen in:"
    $n = [int]$n #getallen omzetten naar een int

    if ($n -lt 1) {
        throw "Aantal moet minstens 1 zijn."
    }

    for ($i = 0; $i -lt $n; $i++) {
        $fibo = $fibo[$i - 1] + $fibo[$i - 2]
    }

    #tonen van de reeks
    $fibo[0..($n -1)]
}
catch {
    Write-Host "Fout bij invoer of berekening!" -ForegroundColor Red
}
