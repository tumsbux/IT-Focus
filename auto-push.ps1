# ======================================================
# auto-push.ps1 — รันทุกวันเพื่อ commit + push ไฟล์ใหม่
# ======================================================

$WORK_DIR = "F:\claude co work"
Set-Location $WORK_DIR

# ตั้ง git identity ทุกครั้ง (ป้องกัน machine ใหม่)
git config user.email "tumsbux.tj@gmail.com"
git config user.name  "tumsbux"

# เพิ่ม remote ถ้ายังไม่มี
$remoteExists = git remote get-url origin 2>$null
if (-not $remoteExists) {
    git remote add origin https://github.com/tumsbux/IT-Focus.git
    Write-Host "✅ Added remote origin" -ForegroundColor Cyan
}

# Stage ไฟล์ที่อนุญาต (ไม่เอาไฟล์ข้อมูลส่วนตัว)
git add index.html
git add status-page.html
git add .gitignore
git add CLAUDE.md
git add "วิธีใช้ Status Page.md"
git add setup-git.ps1
git add auto-push.ps1
git add fix-dashboard-dates.ps1 2>$null

# ตรวจว่ามีการเปลี่ยนแปลงไหม
$changes = git status --porcelain
if ($changes) {
    $date = Get-Date -Format "yyyy-MM-dd HH:mm"
    git commit -m "auto: update status page ($date)"
    git push origin main
    Write-Host ""
    Write-Host "✅ Pushed to GitHub — $date" -ForegroundColor Green
    Write-Host "🌐 https://tumsbux.github.io/IT-Focus/" -ForegroundColor Cyan
} else {
    Write-Host "ℹ️  No changes to push." -ForegroundColor Yellow
}
