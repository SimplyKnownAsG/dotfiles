$env:CODE_HOME="$env:HOMEDRIVE$env:HOMEPATH\codes"
$env:SHARE_HOME="\\albert\home\$env:USERNAME"
$env:PYTHONPATH="$env:CODE_HOME\armi"
if (-not (Test-Path env:HOME)) {
    $env:HOME=$env:USERPROFILE
}
$env:EDITOR="vim --noplugin"
$env:TEMP="$env:CODE_HOME\.temp"
$env:TMP="$env:CODE_HOME\.temp"

New-Alias -Name "py" -Value python
New-Alias -Name "pm" -Value "python -m"
New-Alias -Name "armi" -Value "python -m armi"
New-Alias -Name "up" -Value "cd .."
New-Alias -Name "home" -Value "cd $env:HOME"



function Inject-Intel {
        [CmdletBinding()]
        param([string]$env_script="",
              [string]$arch="intel64",
              [string]$vs="vs2013")

        if ($env_script -eq "") {
                $all_scripts = dir -ErrorAction Ignore -Recurse 'C:\Program Files (x86)\ipsxe-comp-vars.bat'
                foreach ($script in $all_scripts) {
                        Write-Verbose "found script $($script.FullName)"
                }
                $env_script = $($all_scripts | sort -Descending LastWriteTime)[0]
                Write-Verbose "Using $env_script"
        }

        $build_env = cmd /c "$env_script" "$arch" "$vs" `>NUL `& set
        if ($LastExitCode -ne 0) {
                Write-Error "Could not run environment script"
                exit 1
        }

        foreach ($line in $build_env) {
                $eq_loc = $line.IndexOf('=')
                $var = $line.SubString(0, $eq_loc)
                $val = $line.SubString($eq_loc+1)
                try {
                        # if we fail to retrieve the variable, enter catch...
                        $cur = $(get-item -ErrorAction Stop -Path Env:"$var").Value
                        if ($cur -eq $val) {
                                # if they are equal, skip, nice to keep output clean
                                continue
                        }
                        Write-Verbose "updating $var = $val"
                        Set-Item -Path Env:"$var" -Value "$val"
                }
                catch {
                        # this just changes the message from "updating" to "adding"... wheee
                        Write-Verbose "adding $var = $val"
                        Set-Item -Path Env:"$var" -Value "$val"
                }

        }
}
