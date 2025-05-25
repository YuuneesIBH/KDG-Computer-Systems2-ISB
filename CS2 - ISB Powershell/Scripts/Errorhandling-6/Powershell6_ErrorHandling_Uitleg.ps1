# Powershell 6: Error Handling
# ----------------------------
# Voorbeeldscript met uitleg per lijn over error handling concepten

# ----------------------------
# Deel 1: $? uitleggen met ping
# ----------------------------

# Probeer verbinding te maken met je eigen machine via ICMP ping.
ping localhost

# $? bevat of het vorige commando succesvol was.
# Omdat localhost normaal bereikbaar is, zal dit $true zijn.
$?

# Probeer nu te pingen naar een host die niet bestaat.
ping nonexistinghost

# $? zal nu $false zijn, omdat de ping mislukt is.
$?

# ----------------------------
# Deel 2: Gebruik van Get-Process met ErrorAction
# ----------------------------

# Probeer het proces 'notepad' op te halen (zonder dat notepad draait).
Get-Process notepad

# Deze poging zal een fout genereren als notepad niet draait.
# Voeg daarom de optie -ErrorAction SilentlyContinue toe om foutmeldingen te onderdrukken.
Get-Process notepad -ErrorAction SilentlyContinue

# $? toont weer of het vorige commando is geslaagd.
# Omdat notepad niet draaide, is dit $false.
$?

# ----------------------------
# Deel 3: ErrorActionPreference voor hele script instellen
# ----------------------------

# Hiermee onderdruk je alle foutmeldingen in het hele script.
# Pas op: handig voor stille scripts, maar fouten worden dan soms gemist!
$ErrorActionPreference = 'SilentlyContinue'

# ----------------------------
# Deel 4: Try/Catch voorbeeld met expliciete foutopvanging
# ----------------------------

try {
    # Probeer een niet-bestaand bestand te lezen. ErrorAction = stop maakt van de fout een "terminating error".
    $c = Get-Content -Path C:\nonexistingfile.txt -ErrorAction Stop
}
catch {
    # Deze catch blok wordt uitgevoerd als er een fout gebeurt in de try blok hierboven.
    Write-Host "File does not exist" -ForegroundColor Red
    exit 1  # Geeft exitcode 1 terug: dit kan gecontroleerd worden met $? = $false
}

# ----------------------------
# Deel 5: Voorbeeld van documentatie in een scriptbestand
# ----------------------------

<#
.SYNOPSIS
Maakt de som van twee getallen.
.DESCRIPTION
Drukt de som af van 2 getallen die als parameter meegegeven worden.
.EXAMPLE
PS>Maak-Som 3 4
3 + 4 = 7
#>

if ($args.count -ne 2) {
    Write-Output "GEBRUIK: Maak-Som getal1 getal2"
} else {
    Write-Output ($args[0] + $args[1])
}

# ----------------------------
# Deel 6: Oefening 6.2 – Watch-Dog.ps1
# ----------------------------

<#
.SYNOPSIS
Controleert of een programma draait, en start het opnieuw als het niet draait.
.DESCRIPTION
Voert een oneindige loop uit die controleert of een programma loopt.
Als dat niet zo is, wordt het opnieuw opgestart.
.EXAMPLE
.\Watch-Dog.ps1 notepad
#>

param (
    [string]$program,
    [switch]$help
)

if ($help) {
    Write-Output "Gebruik: .\Watch-Dog.ps1 <programmanaam>"
    exit
}

while ($true) {
    # Controleer of het proces draait
    $proc = Get-Process -Name $program -ErrorAction SilentlyContinue
    if (-not $proc) {
        # Start het programma opnieuw op als het niet draait
        Start-Process $program
    }
    # Wacht 2 seconden
    Start-Sleep -Seconds 2
}

# ----------------------------
# Deel 7: Oefening 6.3 – Get-Fibo.ps1
# ----------------------------

# Script dat de eerste n Fibonacci-getallen toont, met foutafhandeling

try {
    $n = Read-Host "Geef aantal Fibonacci-getallen"
    $n = [int]$n  # Probeer om te zetten naar een geheel getal

    if ($n -lt 1) {
        throw "Aantal moet minstens 1 zijn."
    }

    $fibo = @(0, 1)

    for ($i = 2; $i -lt $n; $i++) {
        $fibo += $fibo[$i - 1] + $fibo[$i - 2]
    }

    # Toon de gevraagde reeks
    $fibo[0..($n - 1)]
}
catch {
    # Print een foutmelding als er iets fout gaat
    Write-Host "Fout bij invoer of berekening: $_" -ForegroundColor Red
}
