# Copyright (C) 2012 by ForNeVeR
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Configuration:
$git = 'git'
$dir = 'C:\Temp\test-git-repo'

$watcher = New-Object 'System.IO.FileSystemWatcher'
$watcher.Path = $dir
# TODO: Enable next line after adding .git filter.
$watcher.IncludeSubdirectories = $false

$changed = Register-ObjectEvent $watcher 'Changed' -Action {
	Write-Host "Git path: $git"
	$path = $eventArgs.FullPath
	& $script:git add $path
	& $script:git commit -m "$([System.DateTime]::UtcNow): $path changed."
	Write-Host "Changed: $path"
}

$created = Register-ObjectEvent $watcher 'Created' -Action {
	$path = $eventArgs.FullPath
	& $script:git add $path
	& $script:git commit -m "$([System.DateTime]::UtcNow): $path created."
	Write-Host "Created: $path"
}

$deleted = Register-ObjectEvent $watcher 'Deleted' -Action {
	$path = $eventArgs.FullPath
	& $script:git rm -rf $path
	& $script:git commit -m "$([System.DateTime]::UtcNow): $oldPath removed."
	Write-Host "Deleted: $path"
}

$renamed = Register-ObjectEvent $watcher 'Renamed' -Action {
	$oldPath = $eventArgs.OldFullPath
	$path = $eventArgs.FullPath
	& $script:git mv $oldPath $path
	& $script:git commit -m "$([System.DateTime]::UtcNow): $oldPath renamed."
	Write-Host "Renamed: $oldPath → $path"
}

$watcher.EnableRaisingEvents = $true

# TODO: Unregister events some day.
