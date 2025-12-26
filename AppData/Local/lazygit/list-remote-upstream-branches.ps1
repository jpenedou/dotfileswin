param(
    [String]$SelectedLocalBranch
)

$ErrorActionPreference = 'Stop'
$branch = $SelectedLocalBranch.Trim()
$upstream = git for-each-ref --format='%(upstream:short)' "refs/heads/$branch"

if ([string]::IsNullOrWhiteSpace($upstream)) { exit 1 }

$parts = $upstream -split '/'
if ($parts.Length -lt 2) { exit 1 }

$remote = $parts[0]
$remoteBranch = $parts[1..($parts.Length-1)] -join '/'

git branch -r --format='%(refname:short)' |
    Where-Object { $_ -and $_.StartsWith($remote + '/') } |
    ForEach-Object {
        $name = $_.Substring($remote.Length + 1)
        if ($name -ne $remoteBranch) {
            Write-Output ($remote + '/' + $name)
        }
    } |
    Sort-Object
