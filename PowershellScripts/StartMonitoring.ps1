
### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = "C:\Users\Richard\Desktop"
    $watcher.Filter = "*.*"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true  

### DEFINE ACTIONS AFTER AN EVENT IS DETECTED
    $action = { $path = $Event.SourceEventArgs.FullPath
                $name = $Event.SourceEventArgs.Name
                if($name.Contains("~"))
                {
                    $replaced = $name
                    $replaced = "C:\" + $replaced.Replace("~","\")
                    Write-Host $replaced
					
					$DestinationPath =  $replaced |Split-Path
					
					 if (! (Test-Path -Path $DestinationPath))
					{
						New-Item -ItemType Directory -Path $DestinationPath
					}
					
                    Move-Item -Path $path -Destination $replaced
                    Invoke-Item  $replaced
                }
              }    
### DECIDE WHICH EVENTS SHOULD BE WATCHED 
    Register-ObjectEvent $watcher "Renamed" -Action $action
    while ($true) {sleep 5}