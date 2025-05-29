function Check-Site {
    $logfile = "$HOME\site_check.log"
    while ($true) {
        $tijd = Get-Date
        $pingStatus = if (Test-Connection -ComputerName "localhost" -Count 1 -Quiet) { "SERVER UP" } else { "SERVER DOWN" }
        $httpStatus = if ((Invoke-WebRequest -Uri "http://localhost" -UseBasicParsing -ErrorAction SilentlyContinue).StatusCode -eq 200) { "WEB UP" } else { "WEB DOWN" }

        Add-Content $logfile "$pingStatus $tijd localhost"
        Add-Content $logfile "$httpStatus $tijd localhost"

        Start-Sleep 2
    }
}

#function niet vergeten op te roepen!!
Check-Site