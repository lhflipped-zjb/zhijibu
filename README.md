# 🦞 PM大龙虾 - GitHub Pages 监控看板

## 永久访问链接

部署完成后，看板将通过以下链接永久访问：

**🔗 https://zhijizu.github.io/lobster-dashboard/**

---

## 部署步骤

### 1. 创建GitHub仓库

在GitHub上创建一个新的公开仓库：
- 仓库名: `lobster-dashboard`
- 设置为 Public（公开）
- 不要初始化 README

或者使用GitHub CLI创建:
```bash
gh repo create lobster-dashboard --public
```

### 2. 运行部署脚本

```bash
cd ~/.openclaw/workspace/cloud_dashboard
./deploy.sh
```

### 3. 启用GitHub Pages

1. 打开仓库页面: https://github.com/zhijizu/lobster-dashboard
2. 点击 **Settings** 标签
3. 左侧菜单选择 **Pages**
4. **Source** 选择 **Deploy from a branch**
5. **Branch** 选择 **main** / **root**
6. 点击 **Save**

等待几分钟，页面将部署到: https://zhijizu.github.io/lobster-dashboard/

---

## 更新数据

当任务进度更新时，需要同步更新GitHub Pages:

### 方法1: 自动更新脚本

```bash
cd ~/.openclaw/workspace/cloud_dashboard
python3 update_data.py
./deploy.sh
```

### 方法2: 手动更新

1. 更新 `data.json` 文件
2. 运行 `./deploy.sh`

---

## 文件说明

| 文件 | 说明 |
|------|------|
| `index.html` | 看板主页面（包含静态数据和动态加载逻辑） |
| `data.json` | 任务数据（可被外部更新） |
| `deploy.sh` | 部署脚本 |
| `update_data.py` | 数据更新脚本 |

---

## 特性

- ✅ 响应式设计（手机/平板/电脑）
- ✅ 每30秒自动刷新数据
- ✅ 静态数据嵌入（GitHub Pages兼容）
- ✅ 支持外部data.json动态加载
- ✅ 永久免费托管

---

## 注意事项

1. **数据延迟**: GitHub Pages是静态托管，数据更新需要重新部署
2. **实时数据**: 查看最新进度请查看飞书群推送
3. **访问速度**: 国内访问可能需要科学上网

---

*最后更新: 2026-03-23*
