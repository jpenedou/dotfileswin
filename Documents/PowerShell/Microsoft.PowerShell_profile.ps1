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
Set-Alias lvim 'C:\Users\jpenedo\.local\bin\lvim.ps1'


Function f_pistol { wsl ~/go/bin/pistol }
Set-Alias -name pistol -value f_pistol

# WezTerm, Powershell colores de los parámetros
Set-PSReadLineOption -Colors @{ Parameter = '#999999' }

Invoke-Expression (& { (zoxide init powershell | Out-String) })

function gitd {
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

Set-Alias -Name yz -Value yazi

$env:YAZI_FILE_ONE  = "C:\Program Files\Git\usr\bin\file.exe"
