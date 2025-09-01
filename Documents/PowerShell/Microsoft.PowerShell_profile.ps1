using namespace System.Management.Automation

# UTF8, necesario para PSFzf (Ctrl+t)
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'
Set-PsFzfOption -TabExpansion
set-psfzfOption -EnableAliasFuzzyEdit
set-psfzfOption -EnableAliasFuzzyHistory
set-psfzfOption -EnableAliasFuzzyKillProcess
set-psfzfOption -EnableAliasFuzzySetLocation
set-psfzfOption -EnableAliasFuzzySetEverything
set-psfzfOption -EnableAliasFuzzyGitStatus
$env:FZF_DEFAULT_OPTS = '--height 100% --layout reverse'
# Recordar que es necesario poner el .exe porque fd es un alias a Invode-FuzzySetLocation
$env:FZF_DEFAULT_COMMAND = 'fd.exe '
# La línea de abajo es mucho más lenta que con fd.exe.
# $env:FZF_CTRL_T_COMMAND = 'Get-ChildItem . -Recurse -force'
$env:FZF_CTRL_T_COMMAND = "$env:FZF_DEFAULT_COMMAND"
$env:_PSFZF_FZF_DEFAULT_OPTS = "$env:FZF_DEFAULT_OPTS"

Import-Module -Name Terminal-Icons
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\pure.omp.json" | Invoke-Expression

Invoke-Expression (& { (zoxide init powershell | Out-String) })

# WezTerm, Powershell colores de los parámetros
Set-PSReadLineOption -Colors @{ Parameter = '#999999' }

function dotfiles {
    git --git-dir=$HOME\.dotfiles --work-tree=$HOME $args
}

function lgd {
    $env:GIT_DIR = "$HOME\.dotfiles"
    $env:GIT_WORK_TREE = "$HOME"
    lazygit
    Remove-Item Env:\GIT_DIR, Env:\GIT_WORK_TREE
}
function yzd {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

$env:YAZI_FILE_ONE = "C:\Program Files\Git\usr\bin\file.exe"

Set-Alias -Name yz -Value yazi
Set-Alias -Name v -Value nvim
Set-Alias -Name lg -Value lazygit
Set-Alias cat bat

# Para ouch.exe
# Nota: se ha compilado con
# $env:RUSTFLAGS = "-C link-args=-Wl,--allow-multiple-definition"
# cargo install ouch
$env:Path += ";$env:USERPROFILE\.cargo\bin"

Import-Module posh-sshell

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}