#Maak het bestand keys.csv aan
@"
Path
HKCU:\Software\gdepaepe
HKLM:\Software\gdepaepe
"@ | Out-File -Encoding utf8 keys.csv

#lees de csv in en maak de registry keys aan met waarde oef42
$keys = Import-Csv .\keys.csv
$keys | New-Item -Value "oef42"

#bekijk de inhoud van de reg
Get-Item -Path HKCU:\Software\gdepaepe
Get-Item -Path HKLM:\Software\gdepaepe

#Verwijder da aangemaakte keys
$keys | Remove-Item -Recurse -Force