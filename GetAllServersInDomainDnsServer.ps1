$servers=Get-ADComputer -Filter * -Properties OperatingSystem|where {($_.enabled -like $true) -and ($_.OperatingSystem -like "*windows*")} |select -ExpandProperty DnshostName
foreach ($item in $servers)
{
if (Test-Connection -Count 1 -Server $item -Quiet)
{
    Write-Host $item -ForegroundColor Green
    $NewCSVObject += Invoke-Command -ComputerName $item -ScriptBlock { Get-DnsClientServerAddress } 
}
}
$NewCSVObject | Export-Csv -path C:\temp\DnsConfigurationsFinal.csv
