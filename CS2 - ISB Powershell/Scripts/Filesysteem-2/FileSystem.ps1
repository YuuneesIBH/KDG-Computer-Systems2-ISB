#Test of de file C:\Windows\System32\drivers\etc\hosts bestaat
Test-Path -Path "C:\Windows\System32\drivers\etc\hosts"
True

#Kopieer deze inhoud naar jou home directory
Copy-Item -Path "C:\Windows\System32\drivers\etc\hosts" -Destination $home

#Toon de inhoud
Get-Content -Path "$home\hosts"

#Voeg een lijn toe aan het bestand
Add-Content -Path "$home\hosts" -Value "#Deze file is alternatief voor DNS."

#Verwijder het bestand opnieuw 
Remove-Item -Path "$home\hosts"

#Toon alle functies op het scherm
Get-Command -CommandType Function

#Toon de code van de functie more
(Get-Command more).Definition

#Toon alle registry keys in HKEY_LOCAL_MACHINE
Get-ChildItem -Path HKLM:\

#Maak een alias vi voor de notepad
Set-Alias vi notepad
vi
Remove-Item alias:vi

#Test of de HKCU:\Software/gdp key bestaat
Test-Path -Path "HKCU:\Software/gdp"
False

#Verwijder de HKCU:\Software/gdp key (als die bestaat)
Remove-Item -Path "HKCU:\Software\gdp" 

#Log aan op een windows server met AD en open Powershell
Import-Module ActiveDirectory
Get-PSDrive

#Verwijder de us user UserTestPS via PowerShell
#Stel dat de OU heet Studenten en je domein is kdg dan ziet de DN er zo uit.
"CN=UserTestPS,OU=Studenten,DC=kdg,DC=local"

#We verwijderen de gebruiker met
Remove-ADUser -Identity "CN=UserTestPS,OU=Studenten,DC=kdg,DC=local"

#Of eerst de user opzoeken
Get-ADUser -Filter 'Name -eq "UserTestPS"'

#En dan de user verwijderen
Get-ADUser -Filter 'Name -eq "UserTestPS"' | Remove-ADUser

#Als je werkt met de sub-OUs of complexere structuren kan je ook eerst navigeren via de AD Drive
Set-Location AD:\
cd "OU=Studenten,DC=kdg,DC=local"

#Remove de user
Remove-Item "CN=UserTestPS"