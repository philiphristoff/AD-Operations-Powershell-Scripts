#Start-Transcript C:\temp\logforjava13.txt
$servers = Get-Content 'C:\log_Java_script\servers - Copy.txt'
foreach ($server in $servers)
{
    Write-Host "SCANNING SERVER $server" -BackgroundColor DarkYellow
    Invoke-CommandAs -ComputerName $server -ScriptBlock {
        $drives = Get-CimInstance -Class Win32_LogicalDisk |where {$_.DriveType -eq '3'}|select -ExpandProperty deviceid
        foreach ($drive in $drives)
            {
                Write-Host Scanning drive $drive -BackgroundColor Green
                Get-ChildItem -Path $drive'\' -Include *.jar -Recurse -Force| ForEach-Object {Select-String "JndiLookup.class" $_} | Select FileName, Path, Pattern -Verbose #Select-Object -ExpandProperty Path
            }

        } -AsSystem
}
#Stop-Transcript

#Invoke-CommandAs -ComputerName 
