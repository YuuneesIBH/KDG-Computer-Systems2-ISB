############################
# Powershell Introduction

# This will display the version (PSVersion)
$PSVersionTable

# This will display the processes running on the system
Get-Process

# This will display the services running on the system
Get-Service

# This will display the current location
Get-Location

# This will change the current location to C:\Program Files
Set-Location "c:\Program Files"

# This will display the items in the current location
Get-ChildItem

# This will display the items in the C:\Windows directory that have the .exe extension
Get-ChildItem "c:\Windows" *.exe

# This is the same as the previous command, but with name parameter
Get-ChildItem -Path "c:\Windows" -Filter *.exe

# -Recurse = -r = Recursively
Get-ChildItem -Path "c:\Windows" -Filter *.exe -Recurse

# This will display information about the Get-ChildItem cmdlet
Get-Help Get-ChildItem

# This will display detailed information about the Get-ChildItem cmdlet
Get-Help Get-ChildItem -Detailed

# This will display list of all Get cmdlets
Get-Command Get-*

# This will display list of all cmdlets that have the word "time" in their name
Get-Help time

############################

# Toon alle cmdlets die eindigen op "-object"
Get-Command *-object

# Geef gedetailleerde help voor "Get-Service"
Get-Help Get-Service -Detailed

# Zoek Cmdlets die iets te maken hebben met "output"
Get-Help output
# Or
Get-Command *output*

# Zoek hoe je alle "variabelen" kan tonen
Get-Help *variable*
Get-Variable -Name

# Zijn "sleep", "mkdir", "more" Cmdlets? Wat zijn het dan wel?
Get-Command sleep
Get-Command mkdir
Get-Command more

############################

# This will multiply 2 by 45
2 * 45

# This concatenates the strings "Hello" and "world"
"Hello" + " " + "world"

# This will display the result of 5 + 9
Write-Output (5+9)

# This will display the result of 5 + 9 using the $result variable
$result = (5+9)
Write-Output $result

# This will concatenate variable $home with the string "\Documents"
# Display the ChildItems in the resulting path
Get-ChildItem ($home + "\Documents")

# This will display the current date and time
$datum = Get-Date; Write-Output $datum

############################
# Rekenkundig: +, -, *, /, --, ++
# Assignment: =, +=, -=, *=, /=
# Vergelijken: -eq, -ne, -lt, -le, -gt, -ge
# String: +, -like, -replace
# Redirection: >, >>, 2>, 2>>
# Boolean: $true, $false, -not, !, -and, -or
############################

# Schrijf "Dag wereld" in file "output.txt"
"Dag wereld" > output.txt
Get-Content output.txt

# Voeg resultaat van 256*64 toe aan de file "output.txt"
256*64 >> output.txt
Get-Content output.txt

# Stel de variabele $varCalc gelijk aan de string "calc".
# Voer de inhoud van $varCalc uit als een commando.
$varCalc = "calc"
Invoke-Expression $varCalc
# Or
&$varCalc

# This will get a boolean value of $true
"Dag wereld" -like "*we*"

# This will replace the string "Dag" with "Daaag"
"Dag wereld" -replace "Dag", "Daaag"

############################

# Imlpiciet declaration
$a = 5
$b = "Hello"

# Explicit declaration
[int] $c = 5
[string] $d = "Hello"
[double] $pi=3.14159
[array] $s= @("Hello", "World", "!")

# This will convert the string "5" to an integer
$e = [int] "5"

# This will convert the integer 5 to a string
$f = [string] $a

# Array declaration
$arr1 = @("Hello", "World", "!")
$arr2 = 1, 2, 3

# Display the first element of the array
$arr1[0]
$arr2[0]

# Add an element to the array
$arr1 += "Goodbye"

############################

# This will display the value of the $Env:Path variable
# $Env:Path is a system environment variable
# We can use it to find the location of executables
$Env:Path

# Add a .exe file to the $Env:Path variable (Apache)
$Env:Path += ";c:\apache24\bin"

# Zoek de commanlets voor de volgende aliassen:
# cat, echo, man, ls, ps, cd, pwd, cp, rm, mv, kill, history
Get-Alias -Name "cat", "echo", "man", "ls", "ps", "cd", "pwd", "cp", "rm", "mv", "kill", "history"

# Set the alias "vi" to the "notepad" command
Set-Alias -Name "vi" -Value "notepad"
# Or
Set-Alias vi notepad

############################
# Exercise 1

# Stop alle processen waarvan de naam met een "m" begint in de variabele "$proc"
    # Toon de inhoud van $proc.

    # Welk soort variabele is $proc?
    
    # Toon het 4de element van $proc.

$proc = Get-Process m*
Write-Output $proc
Write-Output $proc.GetType()
Write-Output $proc[3]

# Exercise 2

# Toon alle sub-directories (geen files) van "C:\Program" Files 
# waarvan de naam met een "w" begint en schrijf de output in een 
# file "out.txt" (kies zelf de locatie). Geef de parameternamen mee aan het commando.
    # Toon de inhoud van de file gebruik makende van de Linux alias "cat".

Get-ChildItem -Path "C:\Program Files" -Directory -Filter w* > out.txt
Get-Content out.txt
# Or cat out.txt

# Exercise 3

# Maak een array genaamd $fibo aan met volgende elementen: 1,1,2,3,5,8. 
# gebruik een expliciete declaratie.
    # Tel het "4de" en het "5de" element van $fibo op, converteer het resultaat naar 
    # een string en stop deze in een variabele $som

    # Converteer de variabele $som naar een integer en voeg deze 
    # toe als "6de" element aan de array "$fibo"

[array] $fibo = 1,1,2,3,5,8

$som = [string] ($fibo[4] + $fibo[5])
$fibo += [int] $som

############################

############################
# Powershell File system

pwd # Print working directory
# Or
Get-Location # Get-Location

cd C:\Users\laura # Change directory
# Or
Set-Location C:\Users\laura # Set-Location

New-Item -ItemType Directory -Path C:\Users\laura\Documents\NewFolder # Create a new directory

rm C:\Users\laura\Documents\NewFolder # Remove a directory
# Or
Remove-Item -Path C:\Users\laura\Documents\NewFolder # Remove a directory

cp C:\Users\laura\Documents\NewFolder C:\Users\laura\Documents\NewFolderCopy # Copy a directory
# Or
Copy-Item -Path C:\Users\laura\Documents\NewFolder -Destination C:\Users\laura\Documents\NewFolderCopy # Copy a directory

mv C:\Users\laura\Documents\NewFolder C:\Users\laura\Documents\NewFolderCopy # Move a directory
# Or
Move-Item -Path C:\Users\laura\Documents\NewFolder -Destination C:\Users\laura\Documents\NewFolderCopy # Move a directory

Rename-Item -Path C:\Users\laura\Documents\NewFolder -NewName NewFolderRenamed # Rename a directory

Test-Path -Path C:\Users\laura\Documents\NewFolder # Test if a directory exists

Get-Content -Path C:\Users\laura\Documents\NewFolder\file.txt # Get the content of a file

Set-Content -Path C:\Users\laura\Documents\NewFolder\file.txt -Value "Hello, World!" # Set the content of a file

Add-Content -Path C:\Users\laura\Documents\NewFolder\file.txt -Value "Hello, World!" # Add content to a file
############################

New-Item $home\new_file.txt
New-Item $home\new_dir -type directory
New-Item $home\new_file.txt -type file -force -value "This is text added to the file!`r`n"
Add-Content $home\new_file.txt "This line too!!"
Get-Content $home\new_file.txt
Remove-Item $home\new_dir -Force -Recurse
Remove-Item $home\new_file.*

############################
# Providers

Get-PSDrive # Get the drives in the current session

Get-PSDrive -PSProvider FileSystem # Get the drives in the current session for the FileSystem provider

Get-ChildItem Variable: # Get the variables in the current session
cat .\MaximumDriveCount # Get the content of the MaximumDriveCount variable

Set-Location HKCU: # Set-Location to the HKEY_CURRENT_USER registry key


############################

Get-ChildItem Env:
cd HKCU:\
ls
Set-Location Software
New-Item -Path HKCU:\Software\gdp -Value "gdp key"
ls

############################
# Omgevingsvariabelen

$a = 1 # Set a variable

$env:b = 2 # Set an environment variable

ls env: # List the environment variables

New-Item -Path env:\TEST -Value "Hello, World!" # Create a new environment variable
# Or
$env:TEST = "Hello, World!" # Create a new environment variable

$env:TEST # Get the value of an environment variable

$env:TEST += "!" # Append to an environment variable

Remove-Item -Path env:\TEST # Remove an environment variable
############################

# 1. Test of de file C:\Windows\System32\drivers\etc\hosts bestaat
Test-Path -Path C:\Windows\System32\drivers\etc\hosts
# 2. Kopieer deze file naar jou home directory
Copy-Item -Path C:\Windows\System32\drivers\etc\hosts -Destination C:\Users\laura
# 3. Toon de inhoud van deze file
Get-Content -Path C:\Windows\System32\drivers\etc\hosts
# 4. Voeg volgende lijn toe aan de gekopieerde host file:
# Deze file is een alternatief voor de DNS
Add-Content -Path C:\Users\laura\hosts -Value "Deze file is een alternatief voor de DNS"
# 5. Verwijder deze file uit jou home directory
Remove-Item -Path C:\Users\laura\hosts
# 6. Toon alle functies op het scherm
Get-Command -CommandType Function
# 7. Toon de code van de functie more
Get-Content function:more
# 8. Toon alle registry keys in HKEY_LOCAL_MACHINE
Get-Content HKCU:
# 9. Maak de alias vi uit vorige les terug aan. Test deze uit. Verwijder nu terug deze alias.
New-Alias -Name vi -Value notepad
# 10. Verwijder de HKCU:\Software\gdp key
Remove-Item -Path HKCU:\Software\gdp
# 11. Log aan op een Windows Server met Active Directory en open Powershell:
Import-Module ActiveDirectory
Get-PSDrive
# 11.1. Maak via ADUC een user "UserTestPS" aan onder "OU Studenten"
# /
# 11.2. Navigeer naar de juiste AD map en verwijder de user "UserTestPS" via Powershell
cd AD:
ls
cd "DC=borghijs,DC=local"
ls
cd "OU=Studenten"
Remove-ADUser -Identity "UserTestPS"

############################


############################
# Powershell Pipeline

# Get all processes.
Get-Process

# Open notepad.
notepad

# Get all processes of notepad.
Get-Process notepad

# Get all processes of notepad and format the output in a list.
Get-Process notepad | Format-List

# Get all processes of notepad and format the output in a table.
Get-Process notepad | Format-Table

# Get all processes of notepad and format the output in a table with the "Name" and "Path" properties.
Get-Process notepad | Format-Table Name,Path

# Get all processes of notepad and format the output in a table with all properties.
Get-Process notepad | Format-Table *

# Stop all processes of notepad.
Get-Process notepad | Stop-Process

# Get the first process with the name notepad.
Get-Process notepad | Select-Object -First 1 # of -Last 1

# Sort the processes by the name notepad.
Sort-Object -Property notepad

# Group the processes by the name notepad.
Group-Object -Property notepad

# Count the number of notepad processes.
Measure-Object -Property notepad

# Get the first 5 services.
Get-Service | Select-Object -First 5

# Get date and format the output Date, Month, Year.
Get-date | Select-Object -Property Day,Month,Year

# Get all processes and format the output in a table with the "Name" and "LastWriteTime" and put in a file.
Get-ChildItem | Select-Object LastWriteTime | Sort-Object Name, LastWriteTime > C:\Users\laura\Desktop\output.txt

# Get all services and group them by their status.
Get-Service | Group-Object -Property Status

# Get the number of processes + Format the output.
Get-Process | Measure-Object | Select-Object -Property Count

# Get all services and group them by their status.
Get-Service | Group-Object -Property Status

############################

# Question: What is the difference between the following commands?
Get-date | Select-Object -Property day, month, year
Get-date | Format-Table -Property day, month, year
# Answer: The first command creates a new object, while the second command formats the output.

############################

# Get the date and store it in a variable.
$datum = Get-Date

# Format the output (DayOfWeek)
$datum.DayOfWeek

# Format the output (Month)
$datum.Month

# Add a day to the date.
$datum.AddDays(1)

# () is nessesary to execute the comandlet first to get the object and then the method can be called on the object.
(Get-Date).DayOfWeek

# Get all processes and store them in a variable.
$processes = Get-Process

# Show process 9.
$processes[9]

# Show the name of process 9.
$processes[9].ProcessName

# Show all process names.
$processes.ProcessName

# Show all members of the process object.
"" | Get-Member

# Get string 2 to 5.
"Hallo Wereld".Substring(2,5)

# Define an array.
$rij = 1,2,3,4,5

# Show the first element of the array.
Get-Member -InputObject $rij

# Show the length of the array.
$rij.Length
############################
# -eq, -ne, -lt, -le, -gt, -ge, -like, -not, !, -and, -or

# Get all processes that start with the letter w.
Get-Process | Where-Object {$_.Name -like "w*"}
# Get-Process w*

# Get all processes that have an id lower than 1000.
Get-Process | Where-Object {$_.Id -lt 1000}

# Get all processes that have a status = running.
Get-Service | ? {$_.Status -eq "Running"}

# Get all Running services and stop them.
Get-Service | ? {$_.Status -eq "Running"} | Stop-Service

# Get processes notepad and go through each process and print the id.
Get-Process notepad | Foreach-Object {$_.Id}
# (Get-Process notepad).id

# Get processes notepad and go through each process and kill it.
Get-Process notepad | % {$_.kill()}

# Get all processes and calculate the sum of their ids.
Get-Process | % {$a += $_.id } ; $a

############################

# 1. Show a list of all properties of all subdirectories in your home directory whose names start with a D.
Get-ChildItem D* -Directory | Format-List *

# 2. Display a table with only Fullname and Attributes of all files and directories in your home directory, sorted in reverse by name.
Get-ChildItem | Sort-Object Fullname, Attributes -Descending | Format-Table Fullname, Attributes

# 3. View the methods and properties of Get-Process. Show the title of your Powershell window. Do this again, but now in uppercase.
(Get-Process notepad).MainWindowTitle

# 4. Show the services that the DHCP service depends on.
(Get-Service dhcp).ServicesDependedOn

# 5. Add the VirtualMemorySize of all processes that start with c.
Get-Service c* | ForEach-Object {$size += $_.VirtualMemorySize}
$size

# 6. Create a file "filelist.txt" in your home directory containing the full path names of "c:\windows\win.ini" and "c:\windows\system.ini".
New-Item -Path C:\Users\laura\ -Name filelist.txt -ItemType File
Add-Content -Path C:\Users\laura\filelist.txt -Value "C:\Windows\win.ini"
Add-Content -Path C:\Users\laura\filelist.txt -Value "C:\Windows\system.ini"

# Display the on-screen contents of all files in "filelist.txt". This should also work if you add a file to "filelist.txt".
Get-Content -Path C:\Users\laura\filelist.txt | ForEach-Object {Get-Content $_}

# Drop the "filelist.txt" file.
Remove-Item -Path C:\Users\laura\filelist.txt

############################

############################

# Powershell Object Files

# Get the first 10 services and convert the output to csv.
Get-Service | Select-Object -First 10 | Export-Csv service.csv

# Open the file.
Invoke-Item service.csv

# Import the file.
$service = import-CSV service.csv

# Show the fifth service.
$service[4]

# Delete the file.
Remove-Item service.csv

# Get the first 10 services and convert the output to json.
Get-Service | Select-Object -First 10 | ConvertTo-Json # Or xml or csv

# Convert the json to a powershell object.
'{"name":"laura De Hondt","leeftijd":22}' | ConvertFrom-Json

# Get the first 5 services and convert the output to json and save it to a file.
Get-Service | Select-Object -first 5 -Property Name, Status | ConvertTo-Json | Out-File service.json

# Get the content of the file and convert it to a powershell object.
$service = Get-Content .\service.json | ConvertFrom-Json

# Delete the file.
Remove-Item service.json

# Gat all services and convert the output to html and save it to a file.
Get-Service | ConvertTo-Html | Out-File service.html

# Delete the file.
Remove-Item service.html

############################

New-Item -Path C:\Users\laura\Desktop -Name files.csv -ItemType File
Add-Content -Path C:\Users\laura\Desktop\files.csv -Value "Path;Type"
Add-Content -Path C:\Users\laura\Desktop\files.csv -Value "C:\Temp\Studenten;Directory"
Add-Content -Path C:\Users\laura\Desktop\files.csv -Value "C:\Temp\Docenten;Directory"
Add-Content -Path C:\Users\laura\Desktop\files.csv -Value "C:\Temp\Studenten\Student1;File"
Add-Content -Path C:\Users\laura\Desktop\files.csv -Value "C:\Temp\Docenten\Docent1;File"

$files = Import-Csv .\files.csv -Delimiter ";"
$files
$files.Path
$files | % { New-Item -Path $_.Path -Type $_.Type -Value ""}

############################

# 1. SPut the array below in the variable "$fruit" "meloen;2;stuk","appel;3;kg","banaan;4;kg","kokosnoot;5;stuk".
$fruit = "meloen;2;stuk","appel;3;kg","banaan;4;kg","kokosnoot;5;stuk"

# 1.1. Convert "$fruit" to a list of objects. These objects have the following property names
# "naam","prijs","eenheid". Put this list of objects in the same variable "$fruit".
$fruit = $fruit | ConvertFrom-Csv -Delimiter ";" -Header "naam","prijs","eenheid"

# 1.2. Show next on screen: "$fruit" "$fruit.naam" "$fruit[0]""  "$fruit[3].prijs".
$fruit
$fruit.naam
$fruit[0]
$fruit[3].prijs

# 1.3. Write "$fruit" to JSON file "fruit.json".
$fruit | ConvertTo-Json | Out-File fruit.json
# Test the file.
Get-Content .\fruit.json

# 2.1. #1.3. Write "$fruit" to JSON file "fruit.json".
# HKCU:\Software\gdepaepe
# HKLM:\Software\gdepaepe
New-Item -Path C:\Users\laura\Desktop -Name keys.csv -ItemType File
Add-Content -Path C:\Users\laura\Desktop\keys.csv -Value "Path"
Add-Content -Path C:\Users\laura\Desktop\keys.csv -Value "HKCU:\Software\gdepaepe"
Add-Content -Path C:\Users\laura\Desktop\keys.csv -Value "HKLM:\Software\gdepaepe"

# 2.2. Create the keys in this CSV file in the registry using "binding by property name". Give the following as value "oef42".
# To do this, first add a proper header line to "keys.csv".
Import-Csv -Path C:\Users\laura\Desktop\keys.csv | New-Item -Value "oef42"

# 2.3. View the contents of the registry.
Get-ItemProperty -Path HKCU:\Software\gdepaepe
Get-ItemProperty -Path HKLM:\Software\gdepaepe

# 2.4. Now delete these keys using the same method (be careful: don't delete anything incorrectly!)
Import-Csv -Path C:\Users\laura\Desktop\keys.csv | Remove-Item


# 3.1. The following exercises use "cereal.csv" which contains the data of various grains.
# Find the answer to the following questions by combining a number of Cmdlets via piping.
$cereal = Import-Csv -Path C:\Users\laura\Desktop\cereal.csv -Delimiter ";"

#3.2. Show all grains of type H.
$cereal | Where-Object {$_.type -eq "H"}

# 3.3. How many grains are there with calories equal to 50.
$cereal | Where-Object {$_.calories -eq 50} | Measure-Object

# 3.4. What is the type of the weight property after importing the CSV file.
$cereal.weight | Get-Member

# 3.5. Put the total weight of the grains with calories equal to 50 into a variable "$TotWeight".
$sum = 0
$cereal | Where-Object {$_.calories -eq 50} | ForEach-Object { $sum += [double] $_.weight } ; $sum

############################

############################
# Powershell Scripts

# (-eq is =) (-ne is !=) (-lt is <) (-le is <=) (-gt is >) (-ge is >=)

# Set powershell execution policy to unrestricted
set-executionpolicy unrestricted

# Exemple "if" statement
if ($true) {
    Write-Host "This is true"
} else {
    Write-Host "This is false"
}

# Exemple "switch" statement
$var = 1
switch ($var) {
    1 { Write-Host "One" }
    2 { Write-Host "Two" }
    3 { Write-Host "Three" }
    default { Write-Host "Other" }
}

# Exemple "while" loop
$i = 0
while ($i -lt 5) {
    Write-Host $i
    $i++
}

# Exemple "do while" loop
$i = 0
do {
    Write-Host $i
    $i++
} while ($i -lt 5)

# Exemple "do until" loop
$i = 0
do {
    Write-Host $i
    $i++
} until ($i -eq 5)

# Exemple "foreach" loop
$fruits = @("apple", "banana", "cherry")
foreach ($fruit in $fruits) {
    Write-Host $fruit
}

# Exemple "for" loop
for ($i = 0; $i -lt 5; $i++) {
    Write-Host $i
}

# Exemple "exit" statement
exit

############################

# Prompt the user for input
Write-Host "--------------"

# 
$a = Read-Host "Geef input"

# Clear the console
Clear-Host

# Print the output in a window grid
Get-Process | Out-GridView

# Print the output in a window grid with single selection mode
Get-process | Out-GridView -OutputMode Single

# Print the output in a window grid with multiple selection mode -> $a will be an array
$a = Get-Process | Out-GridView -OutputMode Multiple

############################

# Exemple "parameters" statement
# Maak-Deling.ps1 20 5
if ($args.count -ne 2) {
    Write-Host "GEBRUIK: Maak-Deling deeltal deler"
}
else {
    Write-Host ($args[0] / $args[1])
}

# Exemple "Param" statement
# Maak-Deling.ps1 -deeltal 20 -deler 5
# Maak-Deling.ps1 20 5
Param(
    [int]$deeltal=1,
    [int]$deler=1
)

############################

# Exemple "function" statement
function test1 ($a, $b) {
    return $a + $b
}
test1 1 2

# Exemple "function" statement with default values
function test2 {
    param(
        [int]$a=1,
        [int]$b=1
    )
    return $a + $b
}
test2 1 2

############################

function FahrenhToCelsius ($f) { return ($f - 32) * (5/9) }
FahrenhToCelsius 68

function CelsiusToFahrenh ($c) { return ($c * (9/5)) + 32 }
CelsiusToFahrenh 20

# Show all functions
Get-Command -type Function

# Drop a function
Remove-Item function:FahrenhToCelsius
Remove-Item function:CelsiusToFahrenh

############################


############################
# Powershell ErrorHandling

# Error handling $? variabele

ping localhost
if ($?) {
    Write-Host "Ping succeeded" -ForegroundColor Green
}
else {
    Write-Host "Ping failed" -ForegroundColor Red
}

ping nonexistinghost
if ($?) {
    Write-Host "Ping succeeded" -ForegroundColor Green
}
else {
    Write-Host "Ping failed" -ForegroundColor Red
}

Get-Process notepad -ErrorAction silentlycontinue
if ($?) {
    Write-Host "Process found" -ForegroundColor Green
}
else {
    Write-Host "Process not found" -ForegroundColor Red
}

# Get-Process notepad -ErrorAction silentlycontinue
# $?

$ErrorActionPreference = 'silentlycontinue' # For the entire script

# Error handling try and catch
try {
    $c = Get-Content -Path C:\nonexistingfile.txt -ErrorAction stop
    Write-Host "$c"
}
catch {
    # De $_ variabele bevast het laatste error record
    Write-Host "Exception:" -ForegroundColor Red
    $_.Exception.GetType().FullName
    $_.Exception.Message
    # exit 1 = false
}
# '-ErrorAction stop' This will stop the script when all error occurs


# Scrip Documenation

<#
.SYNOPSIS
    This script demonstrates error handling in PowerShell.
.DESCRIPTION
    This script demonstrates error handling in PowerShell.
.NOTES
    File Name      : W18P3.ps1
    Author         : laura borghijs
    Prerequisite   : PowerShell V2
.EXAMPLE
    PS > .\W18P3.ps1
#>

# Modules

# .psm1 files

# Defolt directory for modules
# My Documents\WindowsPowerShell\Modules\namemodule\namemodule.psm1

# Import-Module namemodule

# Place functions in a .psm1 file and import it with Import-Module

############################

############################
# Powershell Custom Objects

# Hash table
$person = @{Name="Bob"; Age=22}
$person["Name"]
$person["Age"]

# Custom object
[array] $personlist = $null
$person1 = [pscustomobject]@{Name="Bob"; Age=22}

$person1 | Get-Member
$person1.Name
$person1.Age

$personlist += $person1 # Add person to list of persons

$personlist[0].Name
$personlist[0].Age

# Loop through list of persons
foreach ($person in $personlist) {
    Write-Host $person.Name
    Write-Host $person.Age
}

############################
# Exercise 1

# Import CSV file & -Delimiter
$fruit = Import-Csv .\Powershell\data\fruit.csv -Delimiter ","

# Display the first row
$fruit | Get-Member

# Copy the fruit array
[array] $CopiedFruit = $null
$fruit | ForEach-Object { $CopiedFruit += [pscustomobject]@{Fruit=$_.Fruit; Aantal=[int]$_.Aantal} }

# Display the CopiedFruit row
$CopiedFruit | Get-Member

# Sort the fruit by 'aantal'
$CopiedFruit | Sort-Object -Property Aantal

############################

############################
# Powershell Active Directory


# Active Directory Module
Get-Module # View all modules that are loaded

Get-Module -ListAvailable # View all modules that are available

Import-Module ActiveDirectory # Import the Active Directory module

Get-Command -Module ActiveDirectory # View all commands in the Active Directory module


# Get Info of domain
Get-ADDomain # Get info of the domain

Get-ADDomainController # Get info of the domain controller

Get-ADDefaultDomainPasswordPolicy # Get the default domain password policy


# Get Info of users/Computers
Get-ADUser -Filter * # Get all users

Get-ADUser student1 # Get info of a user

Get-ADComputer -Filter * # Get all computers

Get-ADComputer -Identity CLIENT1 # Get info of a computer

Get-ADUser -Filter * | Get-Member # Get all properties of a user

Get-ADUser -Filter {Enabled -eq $true} # Get all enabled users

Get-ADUser -Filter {Name -like "Doc*"} # Get all users with a name starting with "Doc"

Get-ADUser -Filter * | Select-Object Name, Enabled # Get all users with a name starting with "Doc" and only show the Name and SamAccountName

Get-ADUser -Filter * -SearchBase "OU=Studenten,DC=borghijs,DC=local" # Get all users in a specific OU


# Get Info of groups/OUs
Get-ADGroup -Filter * # Get all groups

Get-ADOrganizationalUnit -Filter * # Get all OUs

New-ADGroup -Name "TestGroup" -GroupScope Global -GroupCategory Security # Create a new group

New-ADOrganizationalUnit -Name "TestOU" # Create a new OU

Remove-ADGroup -Identity "TestGroup" # Remove a group

Remove-ADOrganizationalUnit -Identity "TestOU" # Remove an OU


# Enable/disable user, change password
Enable-ADAccount -Identity student1 # Enable a user

Disable-ADAccount -Identity student1 # Disable a user

Set-ADAccountPassword -Identity student1 -NewPassword (ConvertTo-SecureString -AsPlainText "123" -Force) # Change the password of a user
# Set-ADAccountPassword -Identity student1 -NewPassword (ConvertTo-SecureString -AsPlainText "student1" -Force)

############################
# Exercise 1

# Get-ADUser -Filter { name -like "Doc*"}
Get-ADUser -Filter * | Where-Object {$_.name -like "Doc*"}