#toon alle properties van alle subdirectories in je homedirectory die met een D beginnen
Get-ChildItem $home -Directory  | Where-Object {$_.Name -like "D*"} | Format-List *

#toon een tabel met FullName en Attributes van alles in je homedrirectory, omgekeerd gesorteerd op naam
Get-ChildItem $home | Sort-Object Name -Descending | Select-Object FullName, Attributes | Format-Table

#bekijk de titel van het notepad venster in uppercase
notepad
(Get-Process notepad).MainWindowTitle.ToUpper()

#maak een som van VirtualMemorySize van processen die beginnen met een 'c'
Get-Process | Where-Object { $_.Name -like "c*" } | Measure-Object -Property VirtualMemorySize -Sum

#Format Table (toon als tabel)
Get-Process | Format-Table Name, CPU

#Toon als lijst
Get-Process | Format-List Name, Id

#Van de services gaan we de eerste 5 selecteren
Get-Service | Select-Object -first 5

Get-Date | Select-Object -Property day,Month, Year

#Ik maak eerst de folder aan en dan pas ga ik ergens heenschrijven
New-Item -Path "C:\temp" -ItemType -Directory -Force

#Nu ga ik het aantal processen, haalt een lijst van de bestanden en mappen op in de huidige directory,
#die sorteert dan op laatste wiretime, die pakt dan de Naam en LastWriteTime van elke item uit de lijst
#die slaat dan de gesorteerde items op in de list en overschrijft bestand als het bestaat.
New-Item -Path "C:\temp" -ItemType directory -Force
Get-ChildItem | Sort-Object LastWriteTime | Select-Object Name, LastWriteTime > "C:\temp\list.txt"

#Toon alle services waarvan DHCP afhankelijk is
(Get-Service DHCP).DependentServices

#Geef het verschil tussen de volgende ps commands
$services1 = Get-Service | Select-Object Name
$services2 = Get-Service | ForEach-Object { $_.Name }

#De eerste bevat een lijst van objecten met de naam property zelf,
#de tweede bevat een lijst van strings (alleen de namen zelf)

#Maak een bestand filelist.txt
Get-Content filelist.txt
#Toon de inhoud op het scherm van alles in filelist.txt Dit moet ook werken als je een file toevoegt aan filelist.txt
Get-Content filelist.txt | ForEach-Object { Get-Content $_ }