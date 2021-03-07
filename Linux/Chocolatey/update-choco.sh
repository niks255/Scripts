#!/bin/bash

audir="/media/ChocolateyPackages";
cd "$audir" && git reset --hard && git pull;

find "$audir" -name *.nupkg -type f -exec rm -f {} +
find "$audir" -name *.nuspec -type f -exec sed -i 's/tools\\/tools\//g' {} +
find "$audir" -name *.nuspec -type f -exec sed -i 's/legal\\/legal\//g' {} +

powershell "$audir/update_all.ps1"

log="/media/ChocolateyPackages/Update-AUPackages.md";
errors="$(cat /media/ChocolateyPackages/Update-AUPackages.md | grep errors | cut -d ' ' -f1)";

if [ "$errors" -ne 0 ]; then
    /home/scripts/telegram-notify "Обновление пакетов chocolatey завершено с ошибкой" "$log";
fi