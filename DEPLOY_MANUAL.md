# 🦞 PM大龙虾 - GitHub Pages 手动部署指南

由于GitHub CLI需要认证，请按以下步骤手动部署：

---

## 步骤1: 在GitHub上创建仓库

1. 打开 https://github.com/new
2. 填写信息:
   - **Repository name**: `lobster-dashboard`
   - **Description**: `PM大龙虾 - 制剂研发监控看板`
   - **Visibility**: Public ✅
   - **Initialize**: 不要勾选任何选项
3. 点击 **Create repository**

---

## 步骤2: 配置Git凭证

在终端运行:

```bash
# 配置用户名和邮箱
git config --global user.name "zhijizu"
git config --global user.email "your-email@example.com"

# 配置凭证助手
git config --global credential.helper osxkeychain
```

---

## 步骤3: 推送代码

```bash
cd ~/.openclaw/workspace/cloud_dashboard

# 添加所有文件
git add .

# 提交
git commit -m "Initial dashboard deployment"

# 推送（会提示输入GitHub用户名和Token）
git push -u origin main
```

**当提示输入密码时**: 使用GitHub Personal Access Token（不是密码）

### 创建GitHub Token:
1. 打开 https://github.com/settings/tokens
2. 点击 **Generate new token (classic)**
3. 勾选 `repo` 权限
4. 生成后复制token
5. 在git push时，用户名输入 `zhijizu`，密码输入token

---

## 步骤4: 启用GitHub Pages

1. 打开仓库: https://github.com/zhijizu/lobster-dashboard
2. 点击 **Settings** 标签
3. 左侧选择 **Pages**
4. **Source** 选择 **Deploy from a branch**
5. **Branch** 选择 **main** / **/(root)**
6. 点击 **Save**

等待2-3分钟，访问: **https://zhijizu.github.io/lobster-dashboard/**

---

## 快速命令汇总

```bash
# 1. 进入目录
cd ~/.openclaw/workspace/cloud_dashboard

# 2. 更新数据
python3 update_data.py

# 3. 提交并推送
git add .
git commit -m "Update dashboard"
git push

# 4. 一键更新+部署
python3 update_data.py --deploy
```

---

## 文件结构

```
cloud_dashboard/
├── index.html      # 看板主页面
├── data.json       # 任务数据
├── README.md       # 说明文档
├── deploy.sh       # 部署脚本
└── update_data.py  # 数据更新脚本
```

---

## 访问链接

部署完成后，永久链接为：

**🔗 https://zhijizu.github.io/lobster-dashboard/**

---

*创建时间: 2026-03-23*
