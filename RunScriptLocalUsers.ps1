#$servers = Get-ADComputer -SearchBase "DC=it00,DC=biz" -Filter * -Properties operatingSystem|where {($_.Enabled -eq $true) -and ($_.operatingSystem -like "*Windows*")} |select -ExpandProperty Name
$server = "frabpo3pr"
foreach ($Server in $Servers){
if (Test-Connection -Count 2 -ComputerName $server)
{
    Invoke-Command -ComputerName $Server -FilePath C:\Users\gadjevs\Desktop\localusers.ps1 
}

}