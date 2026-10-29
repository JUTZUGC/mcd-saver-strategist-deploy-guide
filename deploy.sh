#!/usr/bin/env bash
set -euo pipefail
# mcd-saver-strategist 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/hujjun/mcd-saver-strategist#安装
# 更新日期：2026-10-29
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v python3 >/dev/null 2>&1 || command -v python >/dev/null 2>&1 || { echo "需要先安装 Python 3"; exit 1; }

mkdir -p .download
cd .download

python -c "import sys; assert sys.version_info >= (3,8), '需要 Python 3.8+，当前 '+sys.version"
git clone https://github.com/hujjun/mcd-saver-strategist.git
cd mcd-saver-strategist/skills/mcd-saver-strategist/scripts
python optimizer.py
echo "离线样例已跑通：接下来配置麦当劳 MCP Token 并复制技能目录"

echo ""

echo "安装完成：先跑 python optimizer.py 看离线样例，再到 open.mcd.cn 申请 Token、配置麦当劳 MCP，最后把技能目录复制进 WorkBuddy"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/hujjun/mcd-saver-strategist#安装"
