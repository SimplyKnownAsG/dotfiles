
$userhome = "$env:HOMEDRIVE$env:HOMEPATH"

function replace-with-link() {
    param([System.IO.FileInfo]$target_path,
          [System.IO.FileInfo]$link_path)

    if (test-path $link_path) {
        Write-Warning "renaming $link_path -> $link_path.bak"
        mv $link_path "$link_path.bak"
    }

    echo "creating link $link_path -> $target_path"
    cmd /c mklink /h $link_path.FullName $target_path.FullName
}

foreach ($target_path in $(dir * -file -Exclude install*,.git*,Microsoft*)) {
    $link_path=join-path $userhome ".$($target_path.Name)"

    replace-with-link $target_path $link_path
}


replace-with-link $(dir Microsoft.Powershell_profile.ps1) $profile
