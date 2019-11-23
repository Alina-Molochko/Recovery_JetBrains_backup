$tools = @("CLion", "DataGrip", "Rider")

echo "Removing evlsprt from options.xml"
echo "Removing eval folder"
foreach ($tool in $tools) {
    $paths = Resolve-Path -Path "$env:USERPROFILE\.$tool*"

    foreach ($path in $paths) {
        # Remove line from options.xml where line contains 'evlsprt'
        $resv_path = Resolve-Path -Path "$path\config\options.xml" -EA SilentlyContinue

        if ($?) {  
            Get-Content $resv_path | where { $_ -notmatch 'evlsprt' } | Out-File -Encoding UTF8 $resv_path
        }

        # Remove eval folder
        $resv_path = Resolve-Path -Path "$path\config\eval\" -EA SilentlyContinue

        if ($?) { 
            Remove-Item $resv_path -Recurse
        }        
    }
}

echo "Removing evlsprt from Windows-Registry"
Get-ChildItem -Path HKCU:\Software\JavaSoft\Prefs\jetbrains -Recurse | Where-Object -FilterScript {($_.Name -match 'evlsprt')} | Remove-Item -Recurse -EA SilentlyContinue