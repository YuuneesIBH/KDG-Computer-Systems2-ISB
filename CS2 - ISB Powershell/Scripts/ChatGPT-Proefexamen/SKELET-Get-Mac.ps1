# Name: Get-Mac.ps1
# Author:
# Date:

param (
    [string]$mode,
    [string]$value
)

$filename = "MacTable.csv"

function Delete-LinesCsv($property, $value, $filename) {
    $filtered = Import-Csv $filename | Where-Object  { $_.$property -ne $value }
    $filtered | Export-Csv ($filename + ".new") -NoTypeInformation -Force
    Move-Item -Path ($filename + ".new") -Destination $filename -Force   
}

#function Write-Mac() {
#    $computer = $env:COMPUTERNAME
#    $time = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

#    $adapters = Get-CimInstance Win32_Networkadapter | Where-Object {
#        $_AdapterType -eq "Ethernet 802.3"
#    }

#    foreach ($adapter in $adapters) {
#        $mac = $adapter.MACAddress
#        if ($mac) {
#            Delete-LinesCsv -property "mac" -value $mac -filename $filename
#            [PSCustomObject]@{
#                data = $time
#                computername = $computer
#                adaptername = $adapter.Name
#                mac = $mac
#            } | Export-Csv $filename -Append -NoTypeInformation -Force
#        }
#    }
#}

function Get-Mac($computername) {
    Import-Csv $filename | Where-Object { $_.computername -like $computername} | Format-Table
}

function Clean-Mac([int]$maxtimespan) {
    $cutoff = (Get-Date).AddDays(-$maxtimespan)

    $filtered = Import-Csv $filename | Where-Object {
        [datetime]::ParseExact($_.date, 'dd/MM/yyyy HH:mm:ss', $null) -ge $cutoff
    }
}

if (!$mode) {
    #Write-Mac
} elseif ($mode -eq "-show" -and $value) {
    Get-Mac $value
} elseif ($mode -eq "-clean" -and $value ){
    Clean-Mac $value
} else {
    Write-Host "Gebruik: .\Get-Mac.ps1 [-show pattern] | [-clean dagen]" -ForegroundColor Green
}