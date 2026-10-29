# mcd-saver-strategist 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/hujjun/mcd-saver-strategist#安装
# 更新日期：2026-10-29
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw '需要先安装 Python 3' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

python -c "import sys; assert sys.version_info >= (3,8), '需要 Python 3.8+，当前 '+sys.version"
git clone https://github.com/hujjun/mcd-saver-strategist.git
Set-Location mcd-saver-strategist/skills/mcd-saver-strategist/scripts
python optimizer.py
Write-Host "离线样例已跑通：接下来配置麦当劳 MCP Token 并复制技能目录"

Write-Host ''

Write-Host '安装完成：先跑 python optimizer.py 看离线样例，再到 open.mcd.cn 申请 Token、配置麦当劳 MCP，最后把技能目录复制进 WorkBuddy'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/hujjun/mcd-saver-strategist#安装'
