#CMDlets bestaan uit een Werkwoord-ZelfstandigNaamWoord

Get-Process
Get-Service 
Get-Location
Get-ChildItem
Set-Location
Get-Command Get*

#OPERATOREN
#Rekenkundig: +, -, *, /, --, ++
#Assignment: =, +=, -=, *=, /=
#Vergelijken: -eq, -ne, -lt, -le, -gt, -ge
#String: +, -like, -replace
#Redirection: >, >>, 2>, 2>>
#Boolean: $true, $false, -not, !, -and, -or

2 + 5 *3
$bericht = "Dag Wereld"
Write-Output $bericht

"Dag Wereld" > output.txt
Get-Location

"Nog een zin" >> output.txt
(256 * 64) >> output.txt

#je kan externe programma's starten zoals
notepad
calc
#ping google.com

ls
pwd
ps

#Eigen alias aanmaken
Set-Alias vi notepad
vi #opent dan notepad
