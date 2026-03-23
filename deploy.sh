#!/bin/bash
# GitHub Pages 部署脚本
# 将监控看板部署到 GitHub Pages 获得永久链接

set -e

echo "🦞 PM大龙虾 - GitHub Pages 部署脚本"
echo "===================================="

# 配置
REPO_NAME="lobster-dashboard"
GITHUB_USER="zhijizu"
REMOTE_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"
LOCAL_DIR="/Users/zhijizu/.openclaw/workspace/cloud_dashboard"

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
cat > .gitignore << 'EOF'
.DS_Store
*.log
EOF

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
    echo ""
    echo "⚠️  注意:"
    echo "  1. 首次部署可能需要几分钟才能在GitHub Pages生效"
    echo "  2. 确保GitHub仓库Settings > Pages中Source设置为'Deploy from a branch' -> 'main'"
    echo "  3. 如果仓库是私有的，页面也是私有的"
else
    echo ""
    echo "❌ 推送失败"
    echo ""
    echo "可能的解决方案:"
    echo "  1. 检查GitHub仓库是否存在: https://github.com/${GITHUB_USER}/${REPO_NAME}"
    echo "  2. 创建仓库: gh repo create ${REPO_NAME} --public"
    echo "  3. 或者手动在GitHub上创建仓库"
    echo "  4. 检查git凭证: git config --global credential.helper osxkeychain"
    exit 1
fi
