#!/bin/sh

audir="/media/ChocolateyPackages";
find "$audir" -name *.nupkg -type f -exec rm -f {} +
find "$audir" -name *.nuspec -type f -exec sed -i 's/tools\\/tools\//g' {} +

powershell "$audir/update_all.ps1"