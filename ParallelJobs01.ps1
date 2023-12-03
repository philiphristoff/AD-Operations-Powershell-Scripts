
$serverlist = Get-Content C:\temp\servers.txt
foreach ($server in $serverlist)
{
    #Start-Job -ScriptBlock {Invoke-Command -ComputerName $server -ScriptBlock {Get-CimInstance -Class Win32_LogicalDisk -ComputerName $server |where {$_.DriveType -eq '3'} | Select-Object DeviceID | ForEach-Object { Get-ChildItem ($_.DeviceID + "\") -Recurse -Include log4j-core*.jar | foreach {select-string "JndiLookup.class" $_} | select FileName, Path, Pattern -verbose }}}

    #Start-Job (Get-CimInstance -Class Win32_LogicalDisk -ComputerName $server)
    #Start-Job -ScriptBlock {Get-CimInstance -Class Win32_LogicalDisk -ComputerName $server|where {$_.DriveType -eq '3'} | Select-Object DeviceID | ForEach-Object { Get-ChildItem ($_.DeviceID + "\") -Recurse -Include log4j-core*.jar -ErrorAction Ignore| foreach {select-string "JndiLookup.class" $_}} | fl *}

   Invoke-Command -ComputerName $server -ScriptBlock {  Get-CimInstance -Class Win32_LogicalDisk -ComputerName $server |where {$_.DriveType -eq '3'} | Select-Object DeviceID | ForEach-Object { Get-ChildItem ($_.DeviceID + "\") -Recurse -Include log4j-core*.jar | foreach {select-string "JndiLookup.class" $_} | select FileName, Path, Pattern -verbose}} -AsJob 
}




#Invoke-Command -ComputerName $($S[0]) -ScriptBlock {  Get-CimInstance -Class Win32_LogicalDisk -ComputerName $server |where {$_.DriveType -eq '3'} | Select-Object DeviceID | ForEach-Object { Get-ChildItem ($_.DeviceID + "\") -Recurse -Include log4j-core*.jar | foreach {select-string "JndiLookup.class" $_} | select FileName, Path, Pattern -verbose }}

#Get-CimInstance -Class Win32_LogicalDisk -ComputerName $server |where {$_.DriveType -eq '3'} | Select-Object DeviceID | ForEach-Object { Get-ChildItem ($_.DeviceID + "\") -Recurse -Include log4j-core*.jar | foreach {select-string "JndiLookup.class" $_} | select FileName, Path, Pattern -verbose }

Start-Job -

$jobWRM = invoke-command -computerName (get-content C:\temp\servers.txt) -scriptblock {get-service winrm} -jobname WinRM -throttlelimit 16 -AsJob

