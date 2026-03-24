#!/bin/bash
# GitHub Pages 部署脚本
# 将监控看板部署到 GitHub Pages 获得永久链接

set -e

echo "🦞 PM大龙虾 - GitHub Pages 部署脚本"
echo "===================================="

# 配置
REPO_NAME="zhijibu"
GITHUB_USER="lhflipped-zjb"
REMOTE_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"
LOCAL_DIR="/Users/zhijizu/.openclaw/workspace/zhijibu"

echo ""
echo "📋 部署配置:"
echo "  仓库名: ${REPO_NAME}"
echo "  用户名: ${GITHUB_USER}"
echo "  远程地址: ${REMOTE_URL}"
echo "  本地目录: ${LOCAL_DIR}"
echo ""

# 检查是否已初始化git
cd "${LOCAL_DIR}"

if [ ! -d ".git" ]; then
    echo "🔧 初始化Git仓库..."
    git init
    git branch -M main
else
    echo "✅ Git仓库已存在"
fi

# 检查远程仓库
if ! git remote | grep -q "origin"; then
    echo "🔗 添加远程仓库..."
    git remote add origin "${REMOTE_URL}"
else
    echo "✅ 远程仓库已配置"
    # 更新远程URL
    git remote set-url origin "${REMOTE_URL}"
fi

# 创建.gitignore
cat > .gitignore << 'IGNORE'
.DS_Store
*.log
IGNORE

# 添加文件
echo ""
echo "📦 添加文件到Git..."
git add index.html data.json .gitignore

# 提交
echo ""
echo "💾 提交更改..."
git commit -m "Update dashboard - $(date '+%Y-%m-%d %H:%M:%S')" || echo "没有更改需要提交"

# 推送到GitHub
echo ""
echo "🚀 推送到GitHub..."
echo "  如果提示输入密码，请使用GitHub Personal Access Token"
echo ""

if git push -u origin main 2>&1; then
    echo ""
    echo "✅ 部署成功！"
    echo ""
    echo "🌐 访问链接:"
    echo "  https://${GITHUB_USER}.github.io/${REPO_NAME}/"
else
    echo ""
    echo "❌ 推送失败"
    exit 1
fi
