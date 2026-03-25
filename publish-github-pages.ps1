Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

param(
  [string]$RepoName = "blessing-love-notes"
)

$repoPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$git = "C:\Program Files\Git\bin\git.exe"
$gh = "C:\Program Files\GitHub CLI\gh.exe"

if (-not (Test-Path (Join-Path $repoPath ".git"))) {
  throw "No local .git repository found in $repoPath"
}

& $gh auth status *> $null
if ($LASTEXITCODE -ne 0) {
  throw "GitHub auth missing. Run: gh auth login --web --git-protocol https --skip-ssh-key"
}

$owner = (& $gh api user --jq .login).Trim()
if ([string]::IsNullOrWhiteSpace($owner)) {
  throw "Could not resolve GitHub username from auth session."
}

$fullRepo = "$owner/$RepoName"
$repoExists = $true
& $gh repo view $fullRepo *> $null
if ($LASTEXITCODE -ne 0) {
  $repoExists = $false
}

if (-not $repoExists) {
  Write-Host "Creating repo $fullRepo..."
  & $gh repo create $fullRepo --public --source $repoPath --remote origin --push
} else {
  Write-Host "Repo exists. Pushing latest changes..."
  $remoteCheck = & $git --git-dir="$repoPath/.git" --work-tree="$repoPath" remote 2>$null
  if ($remoteCheck -notcontains "origin") {
    & $git --git-dir="$repoPath/.git" --work-tree="$repoPath" remote add origin "https://github.com/$fullRepo.git"
  } else {
    & $git --git-dir="$repoPath/.git" --work-tree="$repoPath" remote set-url origin "https://github.com/$fullRepo.git"
  }
  & $git --git-dir="$repoPath/.git" --work-tree="$repoPath" push -u origin main
}

Write-Host "Enabling GitHub Pages (main / root)..."
& $gh api -X POST "repos/$fullRepo/pages" -f "source[branch]=main" -f "source[path]=/" 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "Pages may already be enabled. Continuing..."
}

$pagesUrl = "https://$owner.github.io/$RepoName/"
Write-Host "Done. Your expected site URL:"
Write-Host $pagesUrl
Write-Host "If it shows 404 at first, wait 1-5 minutes and refresh."
