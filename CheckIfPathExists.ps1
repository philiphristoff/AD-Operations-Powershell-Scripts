$servers=Get-ADComputer -Filter * -Properties OperatingSystem|where {($_.enabled -like $true) -and ($_.OperatingSystem -like "*windows*")} |select -ExpandProperty DnshostName
foreach ($item in $servers)
{
if (Test-Connection -Count 1 -Server $item -Quiet)
{
    Write-Host $item -ForegroundColor Green
    Test-Path -Path "C:\Install\Win8.1AndW2K12R2-KB3191564-x64.msu"
}
}