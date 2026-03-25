Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host "Deploying Blessing Love Notes to Cloudflare Pages..."
Write-Host "If this is your first time, run: wrangler login"

wrangler pages deploy . --project-name blessing-love-notes

Write-Host "Done. Copy the URL printed above and share it."
