$servers=Get-ADComputer -Filter * |where {($_.enabled -eq $true) -and (!($_.name -like "*sba*"))} |select -ExpandProperty Name
foreach ($item in $servers)
{
if (Test-Connection -ComputerName $item -Count 2 -Quiet)
{
    #Get-WmiObject -ComputerName $item -Class win32_service |select systemname,name,startname |Export-Csv c:\temp\servicesaccounts_04032021.csv
    #Invoke-Command -ComputerName $item -ScriptBlock {Get-CimInstance -ClassName CIM_Service | where {$_.startname -like "int\*"} | Select-Object Name,StartName} |export-csv C:\temp\servicesaccounts.csv -Append
    Invoke-Command -ComputerName $item -ScriptBlock {schtasks /query /v /fo csv | ConvertFrom-Csv |Select-Object taskname,"run as user"|where {$_."run as user" -like "int\*"}} |Export-Csv c:\temp\serversscheduletasks.csv -Append
}
    
}