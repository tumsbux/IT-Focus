# ======================================================
# setup-git.ps1 — รันครั้งเดียวเพื่อ init + push ขึ้น GitHub
# repo: https://github.com/tumsbux/IT-Focus
# ======================================================

$GITHUB_URL = "https://github.com/tumsbux/IT-Focus.git"
$WORK_DIR   = "F:\claude co work"

Set-Location $WORK_DIR

# Init repo (ถ้ายังไม่มี)
if (-not (Test-Path ".git")) {
    git init
    git branch -M main
}

# Config identity
git config user.email "data.inwza.008@gmail.com"
git config user.name  "Tumsbux_Invincible"

# .gitignore — ไม่เอาไฟล์ข้อมูลส่วนตัว
@"
# LINE chat exports (sensitive)
[LINE]*.txt

# Excel / CSV / PPTX (sensitive data)
*.xlsx
*.csv
*.pptx

# System
Thumbs.db
.DS_Store
desktop.ini
*.lock
"@ | Set-Content .gitignore -Encoding UTF8

# Stage ไฟล์ที่เหมาะสม
git add index.html
git add status-page.html
git add .gitignore
git add CLAUDE.md
git add "วิธีใช้ Status Page.md"
git add setup-git.ps1
git add auto-push.ps1 2>$null

# Commit
$date = Get-Date -Format "yyyy-MM-dd HH:mm"
git commit -m "Initial commit: IT Hub status page ($date)" --allow-empty

# Remote
git remote remove origin 2>$null
git remote add origin $GITHUB_URL
git push -u origin main --force

Write-Host ""
Write-Host "✅ Done! เปิดดูที่: https://github.com/tumsbux/IT-Focus" -ForegroundColor Green
