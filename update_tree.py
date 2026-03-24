import sys
import os
import re

sys.path.append('/Users/zhijizu/.openclaw/workspace')
from scripts.smart_layout_formatter import format_smart_layout

# Extract just the tree text
text = format_smart_layout()
tree_match = re.search(r'```text\n(.*?)```', text, re.DOTALL)
if tree_match:
    tree_text = tree_match.group(1).strip()
else:
    tree_text = text

html_path = '/Users/zhijizu/.openclaw/workspace/zhijibu/index.html'
with open(html_path, 'r', encoding='utf-8') as f:
    html = f.read()

# See if we already have the section
if '<section class="tree-layout"' in html:
    # Replace the existing pre block content
    html = re.sub(
        r'<pre id="smart-tree"[^>]*>.*?</pre>', 
        f'<pre id="smart-tree" style="background:var(--bg); padding:15px; border-radius:8px; font-family:monospace; line-height:1.6; font-size:14px; overflow-x:auto;">{tree_text}</pre>', 
        html, 
        flags=re.DOTALL
    )
else:
    # Insert before <section class="main">
    section_html = f'''<section class="tree-layout" style="margin-top:20px; background:var(--panel); padding:20px; border-radius:12px; border:1px solid var(--line);">
 <h2 style="font-size:18px; color:var(--text); margin-bottom:15px;">🌳 智能阵型战况</h2>
 <pre id="smart-tree" style="background:var(--bg); padding:15px; border-radius:8px; font-family:monospace; line-height:1.6; font-size:14px; overflow-x:auto;">{tree_text}</pre>
 </section>
'''
    html = html.replace('<section class="main">', section_html + '\n <section class="main">')

with open(html_path, 'w', encoding='utf-8') as f:
    f.write(html)
print("Updated index.html with tree layout.")
