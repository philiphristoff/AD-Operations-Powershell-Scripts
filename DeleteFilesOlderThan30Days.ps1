Write-Host "Welcome to the archive example"
$csv = Import-Csv "C:\Vignesh\test.csv"
foreach($row in $csv)
{
    $Path=$row.Path
    write-host "The path to be archived is" $row.Path
    $DaysTOBeArchived = "-30"
    $CurrentDate = Get-Date
    $DatetoBeDeleted = $CurrentDate.AddDays($DaysTOBeArchived)
    Get-ChildItem $Path -Recurse  | Where-Object { $_.CreationTime  -lt $DatetoBeDeleted } | Remove-Item
    Write-Host "Cleared the files is the path "$row.path
}