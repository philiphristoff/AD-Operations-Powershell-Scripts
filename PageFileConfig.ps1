#$servers = Get-ADComputer -Filter * -Properties operatingSystem |where {(($_.dnshostname -like "bp*") -or ($_.dnshostname -like "fr*") -or ($_.dnshostname -like "hr*")) -and ($_.operatingSystem -like "*windows*")} |select -ExpandProperty dnshostname
$servers = Get-Content C:\temp\Wave1PageFileServers.txt
foreach ($item in $servers)
{
    #Write-Host "Page file on server $item" -ForegroundColor Green
    Get-CimInstance -ClassName Win32_PageFileUsage -ComputerName $item | Select-Object Name,AllocatedBaseSize,PSComputerName

}


