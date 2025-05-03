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


# LF FILE MANAGER
#
#
# Autocompletion for powershell.
#
# You need to either copy the content of this file to $PROFILE or call this
# script directly.
#

Register-ArgumentCompleter -Native -CommandName 'lf' -ScriptBlock {
    param($wordToComplete)
    $completions = @(
        [CompletionResult]::new('-command ', '-command', [CompletionResultType]::ParameterName, 'command to execute on client initialization')
        [CompletionResult]::new('-config ', '-config', [CompletionResultType]::ParameterName, 'path to the config file (instead of the usual paths)')
        [CompletionResult]::new('-cpuprofile ', '-cpuprofile', [CompletionResultType]::ParameterName, 'path to the file to write the CPU profile')
        [CompletionResult]::new('-doc', '-doc', [CompletionResultType]::ParameterName, 'show documentation')
        [CompletionResult]::new('-last-dir-path ', '-last-dir-path', [CompletionResultType]::ParameterName, 'path to the file to write the last dir on exit (to use for cd)')
        [CompletionResult]::new('-log ', '-log', [CompletionResultType]::ParameterName, 'path to the log file to write messages')
        [CompletionResult]::new('-memprofile ', '-memprofile', [CompletionResultType]::ParameterName, 'path to the file to write the memory profile')
        [CompletionResult]::new('-print-last-dir', '-print-last-dir', [CompletionResultType]::ParameterName, 'print the last dir to stdout on exit (to use for cd)')
        [CompletionResult]::new('-print-selection', '-print-selection', [CompletionResultType]::ParameterName, 'print the selected files to stdout on open (to use as open file dialog)')
        [CompletionResult]::new('-remote ', '-remote', [CompletionResultType]::ParameterName, 'send remote command to server')
        [CompletionResult]::new('-selection-path ', '-selection-path', [CompletionResultType]::ParameterName, 'path to the file to write selected files on open (to use as open file dialog)')
        [CompletionResult]::new('-server', '-server', [CompletionResultType]::ParameterName, 'start server (automatic)')
        [CompletionResult]::new('-single', '-single', [CompletionResultType]::ParameterName, 'start a client without server')
        [CompletionResult]::new('-version', '-version', [CompletionResultType]::ParameterName, 'show version')
        [CompletionResult]::new('-help', '-help', [CompletionResultType]::ParameterName, 'show help')
    )

    if ($wordToComplete.StartsWith('-')) {
        $completions.Where{ $_.CompletionText -like "$wordToComplete*" } | Sort-Object -Property ListItemText
    }
}

Function f_lfcd { C:\Users\jpenedo\AppData\Local\Microsoft\WinGet\Packages\gokcehan.lf_Microsoft.Winget.Source_8wekyb3d8bbwe\lf.exe -print-last-dir . | set-location }
Set-Alias -name lfcd -value f_lfcd

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

$env:YAZI_FILE_ONE  = "C:\Program Files\Git\usr\bin\file.exe"
