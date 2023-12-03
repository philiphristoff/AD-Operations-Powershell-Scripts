#Stop script

Get-Service Ag*| Stop-Service -PassThru | Set-Service -StartupType disabled

Get-Service World* | Stop-Service -PassThru | Set-Service -StartupType disabled

#Start script
Get-Service Ag* | Set-Service -StartupType automtiac -passThru | Start-Service

Get-Service World* | Set-Service -StartupType automatic -passThru | Start-Service

Get-GPOReport -Name "bpoGpoReport" -ReportType HTML -Path "C:\temp\bpoGpoReport.html"

[datetime]::FromFileTime(132829366080000000)

(Get-HotFix | Sort-Object -Property InstalledOn)[-1]