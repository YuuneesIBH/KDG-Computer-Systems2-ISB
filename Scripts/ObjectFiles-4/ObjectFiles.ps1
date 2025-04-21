Get-Service | Select-Object -First 10 | Export-Csv -Path service.csv
notepad ./service.csv

$services = Import-Csv service.csv #of directe pad  $services = Import-Csv "C:\Users\Younes\service.csv"
$services 
$services[9]
$services[9].Name
$services.Name
Remove-Item service.csv
Get-Service | Select-Object -first 5 -Property Name, Status | ConvertTo-Csv

#JSON objecten
ConvertFrom-Json

'{"name":"younes","leeftijd":21}' | ConvertFrom-Json
Get-Service | Select-Object -First 5 -Property Name,Status | ConvertTo-Json
#opslaan in een file
Get-Service | Select-Object -First 5 -Property Name, Status | ConvertTo-Json | Out-File services.json

#JSON terug uitlegen uit een file
$a = Get-Content .\services.json | ConvertFrom-Json
$a[0].Name

#JSON file verwijderen 
Remove-Item services.json

#HTML 
Get-Service | ConvertTo-Html > services.html
Remove-Item .\services.html

#ik maak een bestand aan files.csv
#Path;Type
#C:\Temp\Studenten;Directory
#C:\Temp\Docenten;Directory
#C:\Temp\Studenten\Student1;File
#C:\Temp\Docenten\Docent1;File

#Dan gaan we de csv inleze 
$files = Import-Csv .\files.csv -Delimiter ";"
$files
$files.Path

$files | Where-Object { $_.Path -and $_.Type } | New-Item -Force -Value ""