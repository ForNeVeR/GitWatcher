Watch-Git
=========

License
-------

Copyright (C) 2012 by ForNeVeR

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

About
-----

Watch-Git is a PowerShell-based tool for watching over a filesystem directory.
All file changes (additions, deletions, etc.) will be commited to git
repository.

Prerequisites
-------------

You'll need a `git` command-line utility. For example, msysgit provides one.

Usage
-----

1. Edit `Configuration` section of `Watch-Git.ps1` file.
2. Run `Watch-Git.ps1`.

Recommended way is to leave entire PowerShell process for exclusive script
functioning (this recomendation of course may be removed in future; feel free to
contact author if you have suggestions).

Script will monitor any changes in the `$dir` directory (as reported by standard
.NET `FileSystemWatcher`) and will call `git add` and `git commit` commands when
on file changes.

Project status
--------------

Project is ready for alpha-testing.
