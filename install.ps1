
$userhome = "$env:HOMEDRIVE$env:HOMEPATH"
if ($userhome -eq "") {
    $userhome = "$env:HOME"
}

$is_windows = [environment]::OSVersion.VersionString -match "Microsoft"

function replace-with-link() {
    param([System.IO.FileInfo]$target_path,
          [System.IO.FileInfo]$link_path)

    write-output "processing $($target_path.FullName)"

    if (test-path $link_path) {
        write-output "    renaming $link_path -> $link_path.bak"
        Move-Item -Force -ErrorAction Ignore $link_path.FullName "$($link_path.FullPath).bak"
    }

    write-output "    creating link $($link_path.FullName) -> $($target_path.FullName)"

    if(!(Test-Path -Path $link_path.DirectoryName )){
        New-Item -ItemType directory -Path $link_path.DirectoryName
    }

    if ($is_windows) {
        cmd /c mklink /h $link_path.FullName $target_path.FullName
    }
    else {
        New-Item -Force -Path $link_path.FullName -ItemType SymbolicLink -Value $target_path.FullName | Out-Null
    }
}

$skip_patterns = 'githooks install .git/ .gitignore Microsoft resources .swp'.Split()

$skips = 0
$processed = 0
foreach ($target_path in $(dir -Recurse -Attributes Hidden,Normal -file *)) {
    $skip = $false
    foreach ($s in $skip_patterns) {
        if ($target_path -match $s) {
            $skip = $true
            break
        }
    }
    if ($skip) { 
        $skips += 1
        continue;
    }
    $processed += 1
    $link_path=join-path $userhome "$($target_path | Resolve-Path -Relative)"

    replace-with-link $target_path $link_path
}

replace-with-link $(dir Microsoft.PowerShell_profile.ps1) $profile

write-output "processed: $processed. skipped: $skips"

# check for vim plugins... if not there, install

if (!(test-path .config/nvim/bundle/Vundle.vim)) {
    write-output "getting Vundle.vim for you"
    git clone https://github.com/VundleVim/Vundle.vim.git $userhome/.config/nvim/bundle/Vundle.vim 2> "&1" | Out-Null
    write-output "    be sure to run 'n?vim +PluginInstall'"
}
