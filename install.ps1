
$userhome = "$env:HOMEDRIVE$env:HOMEPATH"
if ($userhome -eq "") {
    $userhome = "$env:HOME"
}

$is_windows = [environment]::OSVersion.VersionString -match "Microsoft"

function replace-with-link() {
    param([System.IO.FileInfo]$target_path,
          [System.IO.FileInfo]$link_path)

    if (test-path $link_path) {
        Write-Warning "renaming $link_path -> $link_path.bak"
        Move-Item -Force $link_path "$link_path.bak"
    }

    echo "creating link $link_path -> $target_path"

    if(!(Test-Path -Path $link_path.DirectoryName )){
        New-Item -ItemType directory -Path $link_path.DirectoryName
    }

    if ($is_windows) {
        cmd /c mklink /h $link_path.FullName $target_path.FullName
    }
    else {
        New-Item -Path $link_path.FullName -ItemType SymbolicLink -Value $target_path.FullName
    }
}

foreach ($target_path in $(dir * -file -Exclude install*,.git*,Microsoft*)) {
    $link_path=join-path $userhome ".$($target_path.Name)"

    replace-with-link $target_path $link_path
}


replace-with-link $(dir Microsoft.PowerShell_profile.ps1) $profile


