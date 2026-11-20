# Vismatix Universal Agent Pack

One unified knowledge and connection bundle for Claude Code, Cursor, Windsurf, OpenAI Codex, Gemini CLI, and VS Code Copilot.

## Quick start

1. Unzip `vismatix-agent-pack.zip` into your project or agent workspace.
2. Add the `mcpServers.vismatix` entry from `mcp.json` to the client's MCP settings. The remote Streamable HTTP endpoint is `https://vismatix.online/mcp`.
3. Sign in using the client's OAuth flow (OAuth 2.1 with PKCE S256). If the client instead supports secure custom Bearer headers, create a least-privilege Vismatix API key and supply it through a secret manager or `VISMATIX_API_KEY`.
4. Read `VISMATIX_AGENT_GUIDE.md`, then load `AGENTS.md`, `SKILL.md`, and `VISMATIX_FULL_GUIDE.md` as the client supports.

## What's included

- `VISMATIX_FULL_GUIDE.md`: complete public Vismatix knowledge base, including the 84-slot matrix, Hoxi AI, Strategy Radar, workspaces, GC credits, channels, API v3, and security.
- `AGENTS.md` and `SKILL.md`: universal agent behavior and tool workflow guidance.
- `VISMATIX_AGENT_GUIDE.md`: cross-client entry point, resource/tool map, and safe operating sequence.
- `mcp.json`: one remote Streamable HTTP server definition and OAuth/API-key discovery notes.

The MCP server currently exposes 41 tools, 7 static resources, 4 authenticated workspace resource templates, and 9 prompts. Discover live definitions after connecting. Read workspace context before private actions and get explicit confirmation before publishing. ChatGPT uses its dedicated `vismatix-chatgpt-plugin.zip` package.

## Security

OAuth is the recommended sign-in. `vmtx_u_*` keys are account scoped; `vmtx_p_*` keys are restricted to one project. Never place an actual key in this archive, source control, or shared prompt. The `mcp.json` file includes only public endpoints and auth metadata.