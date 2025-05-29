#ik maak nu een Get-Mac waarbij ik nu een CSV inlees 
#een functie DELETE om een bepaalde value te verwijderen 

param(
    [string]$mode,
    [string]$value
)

#verwijder lijnen uit de csv waar een kolom gelijk is aan een opgegeven waarde.
function Delete-LinesCSV($path, $property, $value) {
    if (Test-Path $path) {
        #filter de lijnen waar de opgegeven waarde NIET in voorkomt. 
        Import-Csv $path | Where-Object { $_.$property -ne $value } | Export-Csv $path -NoTypeInformation
    }
}

#haal fysieke ethernetadapters op en schrijf ze weg naar csv
function Write-Mac {
    $computer = $env:COMPUTERNAME
    $time = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

    $adapters = Get-CimInstance Win32_NetworkAdapter | Where-Object {
        $_.AdapterType -eq "Ethernet 802.3" -and $_.MACAddress
    }

    foreach ($adapter in $adapters) {
        Delete-LinesCSV "MacTable.csv" "MACAddress" $adapter.MACAddress

        [pscustomobject]@{
            ComputerName = $computer
            AdapterName  = $adapter.Name
            MACAddress   = $adapter.MACAddress
            Timestamp    = $time
        } | Export-Csv "MacTable.csv" -Append -NoTypeInformation
    }
}

#toon lijnen uit de csv waarvan de ComputerName voldoet aan een patroon 
function Get-Mac($pattern) {
    Import-Csv "MacTable.csv" | Where-Object {
        $_.ComputerName -like $pattern
    } | Format-Table
}


#verwijder lijnen die ouder zijn dan het aantal opgegeven dagen.
function Clean-Mac($dagen) {
    $nu = Get-Date

    Import-Csv "MacTable.csv" | Where-Object {
        # Zet de timestamp string om naar een datetime object
        ($nu - [datetime]::ParseExact($_.Timestamp, "dd/MM/yyyy HH:mm:ss", $null)).Days -le $dagen
    } | Export-Csv "MacTable.csv" -NoTypeInformation
}

#Controller
if ($mode -eq "-show") {
    Get-Mac $value
} elseif ($mode -eq "-clean") {
    Clean-Mac $value
} else {
    Write-Mac
}