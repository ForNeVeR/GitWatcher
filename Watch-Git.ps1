# Configuration:
$git = git
$dir = 'C:\Temp\test-git-repo'

$watcher = New-Object 'System.IO.FileSystemWatcher'
$watcher.Path = $dir

$changed = Register-ObjectEvent $watcher "Changed" -Action {
   write-host "Changed: $($eventArgs.FullPath)"
}
$created = Register-ObjectEvent $watcher "Created" -Action {
   write-host "Created: $($eventArgs.FullPath)"
}
$deleted = Register-ObjectEvent $watcher "Deleted" -Action {
   write-host "Deleted: $($eventArgs.FullPath)"
}
$renamed = Register-ObjectEvent $watcher "Renamed" -Action {
   write-host "Renamed: $($eventArgs.FullPath)"
}

$watcher.EnableRaisingEvents = $true

[System.Threading.Thread]::Sleep(30000)
