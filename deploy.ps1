# PRISM 网站一键发布脚本 (Windows)

Write-Host " 开始构建网站..." -ForegroundColor Green
$env:Path = "C:\Program Files\nodejs;$env:Path"

# 显示调用 npm.cmd
& "C:\Program Files\nodejs\npm.cmd" run build

if ($LASTEXITCODE -ne 0) {
    Write-Host " 构建失败，请检查错误信息。" -ForegroundColor Red
    Pause
    exit
}

Write-Host " 更新发布目录 (docs)..." -ForegroundColor Cyan
if (Test-Path docs) {
    Remove-Item -Recurse -Force docs
}
Copy-Item -Recurse out docs

# 确保 .nojekyll 文件存在
if (-not (Test-Path docs\.nojekyll)) {
    New-Item -ItemType File -Path docs\.nojekyll -Force | Out-Null
}

Write-Host "Git 提交并推送..." -ForegroundColor Yellow
git add .
git commit -m "Update: Auto-deploy via script"
git push origin main

Write-Host " 发布完成！" -ForegroundColor Green
Write-Host " 网站将在几分钟后更新: https://xbc-lcy.github.io" -ForegroundColor Green
Pause
