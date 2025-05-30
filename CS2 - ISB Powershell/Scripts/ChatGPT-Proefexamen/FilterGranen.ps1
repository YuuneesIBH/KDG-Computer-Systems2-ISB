function Filter-Cereals {
    param (
        [string]$minfiber,
        [string]$maxcal
    )

    $data = Import-Csv -Delimiter ";" ./cereal.csv
    $filter = $data | Where-Object {
        [double]$_.fiber -ge $minfiber -and [int]$_.calories -le $maxcal
    }

    if ($filter.Counts -eq 0) {
        Write-Host "Geen granen gevonden die voldoen aan jou criteria!" -ForegroundColor Red    
    } else {
        $filter | Format-Table name, fiber, calories
    }
    
}

$fiber = Read-Host "Minimum aantal vezels?"
$cal = Read-Host "Maximum aantal calorieen?"
Filter-Cereals -minfiber $fiber -maxcal $cal