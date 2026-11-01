# mcd-saver-strategist 一键安装指南

> 第三方部署指南 · 非 mcd-saver-strategist 官方仓库。官方项目：[hujjun/mcd-saver-strategist](https://github.com/hujjun/mcd-saver-strategist)
> 内容来自官方文档（2026-10-29）。项目迭代快，请以[官方文档](https://github.com/hujjun/mcd-saver-strategist#安装)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 把「菜单 × 优惠券 × 叠加规则」交给算法穷举，点餐前先看清哪套组合真的最省。

⚠️ 需要 Python 3.8+，优化器零第三方依赖。真实取菜单、优惠券与下单依赖麦当劳中国 MCP，需要到 open.mcd.cn 用手机号申请 Token；官方示例客户端是 WorkBuddy。真实下单会产生费用，建议先用离线样例和在线试算核对。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/mcd-saver-strategist-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会检查 Python 3.8+，克隆仓库后用内置样例离线跑通优化器，再说明 MCP Token 与技能目录配置，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## mcd-saver-strategist 是什么？

mcd-saver-strategist 是开源的基于麦当劳中国 MCP 的省钱点餐 Skill，用确定性算法枚举菜单、优惠券与叠加规则（协议：MIT，<img src="https://img.shields.io/github/stars/hujjun/mcd-saver-strategist?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

取数交给麦当劳 MCP，算术交给 Python 优化器，表达交给 Agent：穷举菜单、券与叠加规则，输出总价最低的 Top-N 组合，并支持多目标、券体检、凑单、帕累托前沿与多人拼单。

- 组合优化：穷举菜单 × 券 × 叠加规则
- 四种目标：最省、均衡、低卡、少排队
- 券体检：名义面额 vs 实际节省 vs 机会成本
- 凑单建议：算出加购后的净变化
- 帕累托前沿：价格与热量的不可支配解
- 多人拼单：按份数计价、人均分摊
- 离线可跑：内置样例不需要 Token

（来源：[官方仓库](https://github.com/hujjun/mcd-saver-strategist)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 1.5k stars 10 月新项目 | 名称搜索仅 1 条结果 |
| 算法确定性 | 价格和叠加规则不靠模型口算 |
| 离线可试 | 没 Token 也能跑完整优化流程 |
| 场景全 | 单人、拼单、外送、券体检、凑单 |
| 零第三方依赖 | Python 3.8+ 即可 |
| MIT 可商用可二开 | — |

| 需要注意 | 说明 |
|---|---|
| 真实取数与下单依赖麦当劳 MCP 与 Token | — |
| 官方示例客户端是 WorkBuddy 其它客户端要自己适配 | — |
| 只覆盖麦当劳中国 不是通用点餐工具 | — |
| 真实下单要花钱 试错有成本 | — |
| 参赛作品 接口与菜单结构可能变 | — |

> 以上基于官方文档与社区反馈整理（2026-10-29），以官方最新文档为准。

## 快速部署（官方方式）

```bash
python -c "import sys; assert sys.version_info >= (3,8), '需要 Python 3.8+，当前 '+sys.version"
git clone https://github.com/hujjun/mcd-saver-strategist.git
cd mcd-saver-strategist/skills/mcd-saver-strategist/scripts
python optimizer.py
echo "离线样例已跑通：接下来配置麦当劳 MCP Token 并复制技能目录"
```

部署步骤来源：[https://github.com/hujjun/mcd-saver-strategist#安装](https://github.com/hujjun/mcd-saver-strategist#安装)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认 Python 3.8+、零依赖与离线 optimizer.py 用法 | 已核对 2026-10-29 |
| README 确认麦当劳 MCP Token 申请与技能目录位置 | 已核对 2026-10-29 |
| 未实测离线运行与 MCP 接入（未申请 Token） | 说明 2026-10-29 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-10-29 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-29 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目依赖麦当劳中国 MCP（mcp.mcd.cn）获取菜单、优惠券与下单；本仓库的 MCP 只提供安装步骤、Token 配置与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-29）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\mcd-saver-strategist-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 先离线试算（不需要 Token）

```bash
cd skills/mcd-saver-strategist/scripts
python optimizer.py                 # 默认到店自取
python optimizer.py --json          # 结构化输出
python demo.py                      # 7 个场景：拼单 / 外送 / 券体检 / 凑单
python optimizer.py --objective lightest
python optimizer.py --party 3
python optimizer.py --audit
```

也可以直接打开在线试算页：https://hujjun.github.io/mcd-saver-strategist/ ，不用登录。

## 接入麦当劳 MCP

1. 打开 https://open.mcd.cn/mcp ，手机号登录，在控制台激活并复制 Token
2. 在客户端里新增自定义 MCP，填入仓库的 `mcp-config.example.json`，把 `${MCD_MCP_TOKEN}` 换成真实 Token
3. 把 `skills/mcd-saver-strategist/` 复制到客户端技能目录：
   - macOS / Linux：`~/.workbuddy/skills/`
   - Windows：`%USERPROFILE%\.workbuddy\skills\`
4. 在对话框里说「我想吃巨无霸套餐，怎么点最便宜」

## 注意

- 优化器只做计算，真实价格与库存以 MCP 返回为准
- 真实下单会产生费用，先看方案再确认
- Token 是个人凭证，不要提交到仓库或发给别人
- 这是参赛作品，非麦当劳官方产品

## 常见坑

- Python 版本不够：升到 3.8+ 再跑 optimizer.py
- optimizer.py 找不到：确认在 skills/mcd-saver-strategist/scripts 目录
- 没有 Token 也能跑：先跑离线样例，别急着配置 MCP
- MCP 连不上：检查 Token 是否激活、配置里是否替换了占位符
- 价格和 App 不一致：以 MCP 实时返回为准，样例数据是固定的
- Windows 技能目录：用 %USERPROFILE%\.workbuddy\skills\
- 下单前没确认：先看 Top-N 方案，再让 Agent 执行下单

## 免责声明

本仓库为第三方指南，与 mcd-saver-strategist 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-29），项目迭代快，请以[官方文档](https://github.com/hujjun/mcd-saver-strategist#安装)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
