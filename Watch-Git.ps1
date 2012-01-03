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
$global:gitwatch = @{
	git = 'git'
	dir = 'C:\Temp\test-git-repo'
	debug = $true
}

$watcher = New-Object 'System.IO.FileSystemWatcher'
$watcher.Path = $global:gitwatch.dir
$watcher.IncludeSubdirectories = $true

$changed = Register-ObjectEvent $watcher 'Changed' -Action {
	try {
		$path = $eventArgs.FullPath
		if (-not $path.Contains('.git')) {
			& $global:gitwatch.git add $path
			& $global:gitwatch.git commit -m "$([System.DateTime]::UtcNow): $path changed."
			if ($global:gitwatch.debug) {
				Write-Host "Changed: $path"
			}
		}
	} catch {
		Write-Host "Exception: $_"
	}
}

$created = Register-ObjectEvent $watcher 'Created' -Action {
	try {
		$path = $eventArgs.FullPath
		if (-not $path.Contains("\.git")) {
			& $global:gitwatch.git add $path
			& $global:gitwatch.git commit -m "$([System.DateTime]::UtcNow): $path created."
			if ($global:gitwatch.debug) {
				Write-Host "Created: $path"
			}
		}
	} catch {
		Write-Host "Exception: $_"
	}
}

$deleted = Register-ObjectEvent $watcher 'Deleted' -Action {
	try {
		$path = $eventArgs.FullPath
		if (-not $path.Contains('.git')) {
			& $global:gitwatch.git rm -rf $path
			& $global:gitwatch.git commit -m "$([System.DateTime]::UtcNow): $oldPath removed."
			if ($global:gitwatch.debug) {
				Write-Host "Deleted: $path"
			}
		}
	} catch {
		Write-Host "Exception: $_"
	}
}

$renamed = Register-ObjectEvent $watcher 'Renamed' -Action {
	try {
		$oldPath = $eventArgs.OldFullPath
		$path = $eventArgs.FullPath
		# TODO: Check whether file was moved from or inside to repository.
		if (-not $path.Contains('.git')) { 
			& $global:gitwatch.git mv $oldPath $path
			& $global:gitwatch.git commit -m "$([System.DateTime]::UtcNow): $oldPath renamed."
			if ($global:gitwatch.debug) {
				Write-Host "Renamed: $oldPath → $path"
			}
		}
	} catch {
		Write-Host "Exception: $_"
	}
}

$watcher.EnableRaisingEvents = $true

# TODO: Unregister events some day.
