#ik maak een psoef.txt met verschillende paden naar folders
#/Users/youneselazzouzi/Downloads
#/Users/youneselazzouzi/Documents
#/Users/youneselazzouzi/Desktop
#/Users/youneselazzouzi/Pictures
#/Users/youneselazzouzi/Music
#/Users/youneselazzouzi/Movies

Get-Content ./psoef.txt

Get-Content ./psoef.txt | ForEach-Object { Get-ChildItem $_ }

cat ./psoef.txt | % { cat $_ }

#Dit zijn allemaal manieren om de inhoud op te halen van deze files.
#Nu maak ik hieronder gebruik van een script om dezelfde funtionaliteit te bereiken 

#1-ste gebruik van de foreach
New-Item -Path Get-FileContent.ps1 -ItemType File

#Script zelf
filelist = Get-Content psoef.txt

foreach ($file in $filelist) {
    Get-ChildItem $file
}

# uitvoeren
./Get-FileContent.ps1

#2-de gebruik van de for
New-Item -Path Get-ForFileContent.ps1 -ItemType File

$filelist = Get-Content psoef.txt

for ($i = 0; $i -lt $filelist.Count; $i++) {
    Get-ChildItem $filelist[$i]
}

./Get-ForFileContent.ps1