param(
    [String]$SourceBranch,
    [String]$TargetRemoteBranch
)
$ErrorActionPreference = 'Stop'
$sourcebranch = $SourceBranch.Trim()
$targetcombo = $TargetRemoteBranch.Trim()
$parts = $targetcombo -split '/'
$remote = $parts[0]
$targetbranch = $parts[1..($parts.Length-1)] -join '/'
$remoteUrl = git remote get-url $remote
$proto = 'http'
$remoteHost = ''
$path = ''
if ($remoteUrl -match '^(https?)://([^/]+)/(.+?)(?:\.git)?$') {
    $proto = $matches[1]
    $remoteHost = $matches[2]
    $path = $matches[3]
} elseif ($remoteUrl -match '^(ssh://)?git@([^/:]+)[:/]([^\s]+?)(?:\.git)?$') {
    $remoteHost = $matches[2]
    $path = $matches[3] -replace ':', '/'
} else {
    exit
}
$url = $proto + '://' + $remoteHost + '/' + $path + '/-/compare/' + $targetbranch + '...' + $sourcebranch + '?expand=1'
Start-Process $url
