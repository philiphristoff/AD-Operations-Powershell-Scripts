#$servers=Get-ADComputer -Filter * -Properties OperatingSystem -SearchBase "OU=Frankfurt Computer Objects,DC=it00,DC=biz"|where {($_.enabled -like $true) -and ($_.OperatingSystem -like "*windows*") } |select -ExpandProperty DnshostName
$servers = Get-Content C:\temp\bpsserverstest.txt
foreach ($server in $servers)
{
if (Test-Connection $server -Count 2 -Quiet)
{
    #$administrators_members = Get-LocalGroupMember -Group "Administrators"
  #$localusers = Get-WmiObject -ComputerName $server -Class Win32_UserAccount -Filter "LocalAccount=True" |where {$_.Disabled -eq $False} |Select -ExpandProperty caption #, Status, Disabled, AccountType |ft -AutoSize
  #$localusers = Invoke-Command -ComputerName $server -ScriptBlock {net user |select -Skip 4 | select -SkipLast 2}
  $localusers = Invoke-Command -ComputerName $server -ScriptBlock {Get-LocalUser |select Name,PSComputerName}
  write-host $server 
  Write-Host $localusers
  <#foreach ($localuser in $localusers)
  {
   Write-Host $server
   Invoke-Command -ComputerName $server -ScriptBlock {net localgroup administrators | Where {$_ -match $using:localuser}}   
  }#>
}
}

#$u = "Username"; net localgroup administrators | Where {$_ -match $u}

get-localuser