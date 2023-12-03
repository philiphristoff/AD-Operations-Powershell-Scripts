$servers=Get-ADComputer -Filter * -Properties OperatingSystem|where {($_.enabled -like $true) -and ($_.OperatingSystem -like "*windows*")} |select -ExpandProperty DnshostName
foreach ($item in $servers)
{
if (Test-Connection -Count 1 -Server $item -Quiet)
{
#$item="bpodcitzero2.it00.biz"
#Invoke-Command -ComputerName $item.DNSHostName -ScriptBlock {Get-WmiObject win32_bios} |select PSComputerName,SerialNumber
Write-Host $item -ForegroundColor Green
Copy-Item "C:\temp\IISCrypto.exe" -Destination "\\$item\c$\Install" -Force
# Write-Host $item.DNSHostName #, $item.OperatingSystem
}
}