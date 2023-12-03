$localDrives = get-psdrive -PSProvider "FileSystem" 
$foundItems = $null
foreach ($drive in $localDrives)
{
    #Write-Host -ForegroundColor Green "Searching " $drive.Root
	$foundItems += (get-childitem -Path $drive.Root -include log4j-core*jar -Recurse -ErrorAction SilentlyContinue)
} 
$foundItems = $foundItems | sort-object Length -descending 
$foundItems | Format-Table -Property Name,LastWriteTime,Length,CreationTime,Directory -AutoSize
if($null -eq $foundItems)
{
    # Return success
    exit 0
}
else {
    # Return failure code if log4j is found
    exit 1
}