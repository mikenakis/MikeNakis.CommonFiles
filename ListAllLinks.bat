@echo off
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "dir '.' -recurse -force | ?{ $_.LinkType } | select FullName, LinkType, @{ Name = \"Targets\"; Expression = { $_.Target -join \"`t\" } } | Format-List -Force"
