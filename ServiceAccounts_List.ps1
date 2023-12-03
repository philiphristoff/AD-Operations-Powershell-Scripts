#Get-ADUser -SearchBase "OU=Services,OU=UC,OU=Resources,DC=int,DC=sap,DC=corp" -Filter * -Properties *| Where-Object {($_.Enabled -eq $true) -and ($_.PasswordNeverExpires -eq $true)} | Select-Object SamAccountName,PasswordLastSet,DisplayName,description |Export-Csv -Path c:\temp\serviceaccounts1.csv

$servers=Get-ADComputer -Filter *|where {($_.Name -notlike "*sbs*") -and ($_.Name -notlike "*sba*")} |Select-Object -ExpandProperty Name
foreach ($item in $servers)
{
    if (Test-Connection $item -Count 2 -Quiet)
    {
      Get-WmiObject -ComputerName $item -Class win32_service -Property * | Select-Object Name,startname,systemname,state | Add-Content c:\temp\serviceaccounts_onservers_SolarWindsInitiative.txt
    }
}