# auto-push.ps1 - run daily to commit + push updated files

$WORK_DIR = "F:\claude co work"
Set-Location $WORK_DIR

# Set git identity every run (safe on any machine)
git config user.email "tumsbux.tj@gmail.com"
git config user.name  "tumsbux"

# Add remote if missing
$remoteExists = git remote get-url origin 2>$null
if (-not $remoteExists) {
    git remote add origin https://github.com/tumsbux/IT-Focus.git
    Write-Host "[OK] Added remote origin" -ForegroundColor Cyan
}

# Stage allowed files only (no sensitive LINE/Excel/CSV data)
git add index.html
git add status-page.html 2>$null
git add .gitignore 2>$null
git add CLAUDE.md 2>$null
git add setup-git.ps1 2>$null
git add auto-push.ps1
git add first-time-push.ps1 2>$null

# Check for changes
$changes = git status --porcelain
if ($changes) {
    $date = Get-Date -Format "yyyy-MM-dd HH:mm"
    git commit -m "auto: update status page ($date)"
    git push origin main
    Write-Host ""
    Write-Host "[DONE] Pushed to GitHub -- $date" -ForegroundColor Green
    Write-Host "[LIVE] https://tumsbux.github.io/IT-Focus/" -ForegroundColor Cyan
} else {
    Write-Host "[--] No changes to push." -ForegroundColor Yellow
}
