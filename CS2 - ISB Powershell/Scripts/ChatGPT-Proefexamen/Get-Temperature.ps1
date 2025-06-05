# Name: Get-Temperature.ps1
# Author: Younes El Azzouzi
# Date: 05/06/2025

<#
.SYNOPSIS
    Analyseert gegevens van temperatuur data op basis van een CSV-bestand.

.DESCRIPTION
    Dit is het script dat ik (Younes El Azzouzi) oplever voor het examen CS2 ISB Powershell

.EXAMPLE
    .\Get-Temperature.ps1
#>

Param(
  [string]$file = "./temperatuur.csv"
)

try {
  $weerdata = Import-Csv $file -Delimiter ";"
} catch {
  Write-Host "ERROR: Kon het bestand niet vinden!" -ForegroundColor Red
  exit 1
}

if ($weerdata.Count -eq 0) {
  Write-Host "ERROR: Je hebt een leeg bestand geïmporteerd!" -ForegroundColor Red
  exit 1
}

function Get-Distance($Lon1, $Lat1, $Lon2, $Lat2) {
  return [Math]::Sqrt([Math]::Pow(71*([Float]$Lon2 - [Float]$Lon1),2) + [Math]::Pow(111*([Float]$Lat2 - [Float]$Lat1),2))
} 

function Convert-Numbers($weerdata) {
  $converted = $weerdata | ForEach-Object {
      [pscustomobject]@{
          Sid = $_.Sid
          Datum = $_.Datum
          Longitude = [float]$_.Lon
          Latitude = [float]$_.Lat
          Temperatuur = [float]$_.Temp
      }
  }
  return $converted
}

function Get-Temperature($weerdata, $datum) {
  return $weerdata | Where-Object { $_.Datum -eq $datum } | Select-Object Sid, Datum, Temperatuur -First 5
}

function Get-StationTemperature {
  Param(
      [array]$weerdata,
      [string]$sid,
      [string]$datum
  )
  return $weerdata | Where-Object { $_.Datum -like "$datum*" -and $_.Sid -eq $sid} | Select-Object Sid, Datum, Temperatuur
}

function Get-MaxTemperature($weerdata, $sid) {
  return $weerdata | Where-Object { $_.Sid -eq $sid } | Sort-Object Temperatuur -Descending | Select-Object -First 1 Sid, Temperatuur
}

function Get-AverageTemperature($weerdata, $datum) {
  return $weerdata | Where-Object { $_.Datum -eq $datum } | Measure-Object -Property Temperatuur -Average
}
  
function Get-Stations($weerdata) {
  return $weerdata | Sort-Object Sid -Unique | Select-Object Sid, Longitude, Latitude -First 3
}

function Get-NearStations($stations, $lon, $lat, $dist) {
  return $stations | Where-Object {
      (Get-Distance $_.Longitude $_.Latitude $lon $lat) -lt $dist
  }
}

# Hoofdprogramma: hier niks wijzigen
# Linux: vervang alle Out-GridView door Format-Table
# Haal de lijnen uit commentaar voor de functies die werken
# Voor functies die niet werken: laat deze in commentaar staan
# Zo lever je een werkend script af

$datum="2/04/2024"
$dag1="1/*"
$sid="10500"

$weerdata = Convert-Numbers $weerdata
# Test of properties het juiste type hebben
$weerdata | Get-Member

Get-Temperature $weerdata $datum | Format-Table
Get-StationTemperature -weerdata $weerdata -datum $dag1 -sid $sid | Format-Table
Get-MaxTemperature $weerdata $sid 
Get-AverageTemperature $weerdata $datum
Get-Stations $weerdata | Format-Table

# Alle weerstation die minder dan 50 km van Antwerpen (lon=4,4 lat=51,22) liggen
#Get-NearStations (Get-Stations $weerdata) 4.4 51.22 50 | Format-Table