<#  
.SYNOPSIS  
    Script met alle PowerShell-commando's uit de Active Directory en DNS slides, inclusief uitleg per regel.  
.DESCRIPTION  
    Dit script bevat de belangrijkste cmdlets om Active Directory en DNS te beheren, met commentaar bij elk commando.  
.AUTHOR  
    Naam: [Jouw Naam]  
.VERSION  
    1.0  
#>  

# ----------------------------------------
# Sectie 1: Active Directory module
# ----------------------------------------

# Toon alle momenteel geladen modules in de sessie
Get-Module

# Toon alle modules die op het systeem beschikbaar zijn
Get-Module -ListAvailable

# Laad de Active Directory PowerShell-module in de huidige sessie
Import-Module ActiveDirectory

# Toon alle cmdlets die beschikbaar zijn in de ActiveDirectory module
Get-Command -Module ActiveDirectory

# ----------------------------------------
# Sectie 2: Domeininformatie ophalen
# ----------------------------------------

# Haal informatie op over het huidige Active Directory-domein
Get-ADDomain

# Haal informatie op over één of meerdere domeincontrollers in het domein
Get-ADDomainController

# Toon de standaard wachtwoordbeleid-instellingen van het domein
Get-ADDefaultDomainPasswordPolicy

# ----------------------------------------
# Sectie 3: Gebruikers en computers beheren
# ----------------------------------------

# Toon een individuele AD-gebruiker op basis van de Identity (bijv. gebruikersnaam)
Get-ADUser -Identity student1

# Toon een individuele AD-computer op basis van de Identity (bijv. computernaam)
Get-ADComputer -Identity Win10

# Haal alle AD-gebruikers op (Filter *)
Get-ADUser -Filter *

# Toon alle eigenschappen van ADUser-objecten (Get-Member toont properties/methods)
Get-ADUser -Filter * | Get-Member

# Filter gebruikers op ingeschakeld (Enabled -eq $true)
Get-ADUser -Filter {Enabled -eq $true}

# Filter gebruikers waarvan de naam begint met "Doc"
Get-ADUser -Filter {Name -like "Doc*"}

# Haal alle gebruikers op binnen een specifieke Organizational Unit (SearchBase)
Get-ADUser -Filter * -SearchBase "OU=OUStud,DC=paepe,DC=local"

# Maak een nieuw AD-gebruikersaccount aan (voorbeeldparameters)
New-ADUser -Name "nieuweGebruiker" `
           -SamAccountName "nieuweGebruiker" `
           -DisplayName "Nieuwe Gebruiker" `
           -AccountPassword (ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) `
           -Enabled $true `
           -Path "OU=OUStud,DC=paepe,DC=local"

# Verwijder een AD-gebruiker zonder bevestiging
Remove-ADUser -Identity student1 -Confirm:$false

# Maak een nieuw AD-computeraccount aan
New-ADComputer -Name "NieuweComputer" -Path "OU=Computers,DC=paepe,DC=local"

# Verwijder een AD-computeraccount zonder bevestiging
Remove-ADComputer -Identity Win10 -Confirm:$false

# ----------------------------------------
# Sectie 4: Groepen en OU's beheren
# ----------------------------------------

# Toon alle AD-groepen
Get-ADGroup -Filter *

# Toon alle Organizational Units
Get-ADOrganizationalUnit -Filter *

# Maak een nieuwe AD-groep aan
New-ADGroup -Name "NieuweGroep" -GroupScope Global -Path "OU=Groepen,DC=paepe,DC=local"

# Maak een nieuwe OU aan
New-ADOrganizationalUnit -Name "NieuweOU" -Path "DC=paepe,DC=local"

# Verwijder een AD-groep zonder bevestiging
Remove-ADGroup -Identity "OudeGroep" -Confirm:$false

# Verwijder een OU zonder bevestiging
Remove-ADOrganizationalUnit -Identity "OU=TeVerwijderen,DC=paepe,DC=local" -Confirm:$false

# ----------------------------------------
# Sectie 5: Gebruikers inschakelen, uitschakelen en wachtwoord wijzigen
# ----------------------------------------

# Schakel een AD-account in
Enable-ADAccount -Identity student1

# Schakel een AD-account uit
Disable-ADAccount -Identity student1

# Stel het wachtwoord van een AD-account opnieuw in
Set-ADAccountPassword -Identity student1 -Reset `
    -NewPassword (ConvertTo-SecureString -AsPlainText "NieuwP@ss" -Force)

# ----------------------------------------
# Sectie 6: DNS Server module
# ----------------------------------------

# Toon alle momenteel geladen modules
Get-Module

# Toon alle modules die op het systeem beschikbaar zijn
Get-Module -ListAvailable

# Laad de DNS Server PowerShell-module
Import-Module DnsServer

# Toon alle cmdlets in de DnsServer module
Get-Command -Module DnsServer

# ----------------------------------------
# Sectie 7: DNS-records beheren
# ----------------------------------------

# Haal de DNS-root van het huidige AD-domein op
$dnsRoot = (Get-ADDomain).DNSRoot

# Toon alle resource records in de DNS-zone van het domein
Get-DnsServerResourceRecord -ZoneName $dnsRoot

# Voeg een nieuwe primaire DNS-zone toe voor 'voorbeeld.local'
Add-DnsServerPrimaryZone -Name "voorbeeld.local" -ReplicationScope "Forest"

# Voeg een CNAME-record toe (alias 'www' wijst naar 'server.voorbeeld.local')
Add-DnsServerResourceRecordCName -ZoneName "voorbeeld.local" `
    -Name "www" -HostNameAlias "server.voorbeeld.local"

# Verwijder een CNAME-record zonder bevestiging
Remove-DnsServerResourceRecord -ZoneName "voorbeeld.local" `
    -RRType CNAME -Name "www" -Force

# Verwijder een DNS-zone zonder bevestiging
Remove-DnsServerZone -Name "voorbeeld.local" -Force
