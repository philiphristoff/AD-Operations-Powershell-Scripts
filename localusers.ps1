Write-Host $server -ForegroundColor Green
    #Invoke-Command -ComputerName $Server -ScriptBlock {
        $users = Get-LocalUser |where {$_.Enabled -like $True} |select -ExpandProperty Name
        $GroupMembers = net localgroup administrators |select -Skip 6 |select -SkipLast 2
            $users |ForEach-Object {
                if ($_ -in $GroupMembers)
                    {
                       #Write-Host $server
                       Write-Host $_ YES -ForegroundColor Green
                    }
                else {
                        Write-Host $_ NO -ForegroundColor Red
                     }
                }
           # }