#!/usr/bin/env python3
"""
自动更新GitHub Pages看板数据
从本地task_monitor.json同步到zhijibu/data.json
"""

import json
import shutil
from pathlib import Path
from datetime import datetime

def update_dashboard_data():
    """更新看板数据"""
    
    # 路径配置
    workspace = Path("/Users/zhijizu/.openclaw/workspace")
    source_file = workspace / "data" / "task_monitor.json"
    target_file = workspace / "zhijibu" / "data.json"
    
    if not source_file.exists():
        print(f"❌ 源文件不存在: {source_file}")
        return False
    
    # 读取源数据
    with open(source_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    # 确保数据格式正确
    dashboard_data = {
        "task_id": data.get("task_id", "UNKNOWN"),
        "task_name": data.get("task_name", "未命名任务"),
        "start_time": data.get("start_time", datetime.now().strftime("%Y-%m-%d %H:%M:%S")),
        "update_time": data.get("update_time", datetime.now().strftime("%Y-%m-%d %H:%M:%S")),
        "overall_progress": data.get("overall_progress", 0),
        "status": data.get("status", "未知"),
        "agents": data.get("agents", {})
    }
    
    # 写入目标文件
    with open(target_file, 'w', encoding='utf-8') as f:
        json.dump(dashboard_data, f, ensure_ascii=False, indent=2)
    
    print(f"✅ 数据已更新: {target_file}")
    print(f"   任务: {dashboard_data['task_name']}")
    print(f"   进度: {dashboard_data['overall_progress']}%")
    print(f"   Agent数: {len(dashboard_data['agents'])}")
    
    return True

def deploy_to_github():
    """部署到GitHub Pages"""
    import subprocess
    
    dashboard_dir = Path("/Users/zhijizu/.openclaw/workspace/zhijibu")
    
    try:
        # 进入目录
        result = subprocess.run(
            ["./deploy.sh"],
            cwd=dashboard_dir,
            capture_output=True,
            text=True
        )
        
        print(result.stdout)
        
        if result.returncode == 0:
            print("✅ 部署成功!")
            return True
        else:
            print(f"❌ 部署失败: {result.stderr}")
            return False
            
    except Exception as e:
        print(f"❌ 部署出错: {e}")
        return False

if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="更新GitHub Pages看板数据")
    parser.add_argument("--deploy", action="store_true", help="更新后自动部署")
    
    args = parser.parse_args()
    
    print("🦞 PM大龙虾 - 更新GitHub Pages看板数据")
    print("=" * 50)
    
    if update_dashboard_data():
        if args.deploy:
            print("")
            deploy_to_github()
    else:
        print("❌ 数据更新失败")
