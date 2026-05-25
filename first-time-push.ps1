# first-time-push.ps1

$WORK_DIR   = "F:\claude co work"
$GITHUB_URL = "https://github.com/tumsbux/IT-Focus.git"

Write-Host "=== IT-Focus Git Reset & Push ===" -ForegroundColor Cyan
Set-Location $WORK_DIR

# 1. ลบ .git เก่า
if (Test-Path ".git") {
    Remove-Item -Recurse -Force ".git"
    Write-Host "[OK] Removed old .git" -ForegroundColor Green
}

# 2. Init ใหม่
git init
git branch -M main
Write-Host "[OK] git init done" -ForegroundColor Green

# 3. Identity
git config user.email "tumsbux.tj@gmail.com"
git config user.name  "tumsbux"
Write-Host "[OK] Identity: tumsbux / tumsbux.tj@gmail.com" -ForegroundColor Green

# 4. Remote
git remote add origin $GITHUB_URL
Write-Host "[OK] Remote added" -ForegroundColor Green

# 5. Fetch + sync กับ GitHub
Write-Host "[..] Fetching from GitHub..." -ForegroundColor Yellow
git fetch origin
git reset --hard origin/main
Write-Host "[OK] Synced with GitHub" -ForegroundColor Green

# 6. Stage files
git add index.html
git add auto-push.ps1
git add first-time-push.ps1
git add .gitignore 2>$null
git add CLAUDE.md 2>$null

# 7. Commit
$changes = git status --porcelain
if ($changes) {
    $date = Get-Date -Format "yyyy-MM-dd HH:mm"
    git commit -m "update: daily status page $date"
    Write-Host "[OK] Committed" -ForegroundColor Green
} else {
    Write-Host "[--] No changes to commit" -ForegroundColor Yellow
}

# 8. Push
Write-Host "[..] Pushing to GitHub..." -ForegroundColor Yellow
git push origin main

Write-Host ""
Write-Host "[DONE] https://github.com/tumsbux/IT-Focus" -ForegroundColor Green
Write-Host "[DONE] https://tumsbux.github.io/IT-Focus/" -ForegroundColor Green
Write-Host "[NEXT] Run auto-push.ps1 every day" -ForegroundColor Cyan
