Get-Process -Name $args[0] -Id |foreach { Write-Host $_ }


