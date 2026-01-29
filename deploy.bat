@echo off
chcp 65001 >nul
echo ==========================================
echo       PRISM 网站一键发布工具
echo ==========================================
echo.

:: 临时绕过权限限制运行 PowerShell 脚本
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0deploy.ps1'"

echo.
echo ==========================================
if %ERRORLEVEL% EQU 0 (
    echo [成功] 脚本执行完毕，请等待 GitHub Pages 更新。
) else (
    echo [错误] 脚本执行出错，请检查上方报错信息。
)
pause