$emailto = 'svetoslav.gadjev@dxc.com','sggadjev@gmail.com'
$emailfrom = "pdl-bpo-gcb-win@dxc.com"
$emailsubject = "Log4J report" 
$emailsmtp = "138.35.24.152"
Clear-host
Function Add-LogEntry ($Value) {
    $datetime = get-date -format "dd-MM-yyyy HH:mm:ss"
    add-content -Path $log -Value "$($datetime): $value"
}

#end of functions

#create a logfile snippet
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath

#get date and check if logfile for the day exists, if not, create it.
$date = get-date -Format "hh-mm-ss-dd-MM-yyyy"
$log = "$dir\logs\Log-$date.log"
if ((test-path $log) -eq $false) {
    if ((test-path "$dir\logs") -eq $false) { new-item -Path $dir -name "Logs" -ItemType Directory -ErrorAction SilentlyContinue -Force -Verbose}
    new-item -Path "$dir\logs" -Name "Log-$date.log" -force -verbose
    Add-LogEntry -Value "Log file created"
}

#$servers = get-content -Path C:\log_Java_script\serverstest.txt
$servers = Get-ADComputer -Filter * |where {($_.dnshostname -like "bp*") -or ($_.dnshostname -like "fr*") -or ($_.dnshostname -like "hr*")} |select -ExpandProperty dnshostname

Add-LogEntry -Value "Server list imported"
Add-LogEntry -value ""

foreach ($server in $servers) {
    $s = $server.split(".")
    Write-host "Connecting to $($S[0])" -foregroundcolor Yellow
    Add-LogEntry -Value "Connecting to $($S[0])"
    #test connection to server
    if (Test-Connection -ComputerName $server -BufferSize 1 -Count 1) {
        try {
            Write-host "`t└ $($S[0]) is online" -foregroundcolor Cyan  
            Add-LogEntry -Value `t"$($S[0]) is online"
            Write-host "`t└ Checking for log4j*.jar files....." -foregroundcolor Yellow
            Add-LogEntry -Value "Scanning for log4j*.jar files ..."
            $results = Invoke-Command -ComputerName $($S[0]) -ScriptBlock {  Get-CimInstance -Class Win32_LogicalDisk -ComputerName $server |where {$_.DriveType -eq '3'} | Select-Object DeviceID | ForEach-Object { Get-ChildItem ($_.DeviceID + "\") -Recurse -Include log4j-core*.jar | foreach {select-string "JndiLookup.class" $_} | select FileName, Path, Pattern -verbose }}
            
            foreach ($result in $results) {
                if (($($result.filename) -eq 'log4j-core-2.16.jar') -or ($($result.filename) -eq 'log4j-core-2.17.jar')) {
                    Write-host "`t`t└ $($result.filename) found on $($S[0]), but it's safe version 2.16/2.17" -foregroundcolor Cyan
                    Write-host "`t`t└ $($result.Path)"-ForegroundColor Gray
                   add-logentry -value "Information, $($result.filename) found on $($S[0]) with $($result.Pattern) on path $($result.Path) but it's safe version"
                } else  {
                    Write-host "`t`t└ $($result.filename) found on $($S[0])" -foregroundcolor Magenta
                    Write-host "`t`t└ $($result.Path)"-ForegroundColor Gray
                    add-logentry -value "Warning!, $($result.filename) found on $($S[0]) with $($result.Pattern) on path $($result.Path)"
                }
                
            }
       }
       Catch {
            Write-host "`t└ an error occurred! on $($S[0])" -foregroundcolor Red
            Add-Logentry -value "An error occured on $($S[0])"
       }
    Write-host "`t└ $($S[0]) search completed" -foregroundcolor Green
    Add-LogEntry "$($S[0]) search completed"
    Add-LogEntry -value ""
           
    }
}


Send-MailMessage -from $emailfrom -to $emailto -subject $emailsubject -body "Log4j _report for BPO - TEST" -smtpServer $emailsmtp -attachments $log

Select after the line break all do is if else then script call main v main v main v main 
{
}