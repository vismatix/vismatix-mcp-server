# Vismatix Universal Agent Pack

One unified knowledge and connection bundle for Claude Code, Cursor, Windsurf, OpenAI Codex, Gemini CLI, and VS Code Copilot.

## Quick start

1. Unzip the bundle in a folder your agent can read.
2. Follow `START_HERE.md` and add the Vismatix remote MCP endpoint `https://vismatix.online/mcp` in your client's MCP settings.
3. Complete OAuth 2.1 sign-in with PKCE S256. Use a Bearer API key only when the client offers secure secret storage and supports custom authorization headers.
4. Keep `AGENTS.md` loaded. Load `SKILL.md` for MCP work; search the full guide and workflow examples only when relevant.

## What's included

- `VISMATIX_FULL_GUIDE.md`: complete public Vismatix knowledge base, including the 84-slot matrix, Hoxi AI, Strategy Radar, workspaces, GC credits, channels, API v3, and security.
- `AGENTS.md`: concise always-on rules for grounding, tenant isolation, privacy, and safe changes.
- `SKILL.md`: Vismatix MCP resources, tools, workflow prompts, and recovery guidance.
- `VISMATIX_AGENT_GUIDE.md`: product facts, cross-client orientation, and live MCP capability map.
- `START_HERE.md`: setup and first-run sequence.
- `WORKFLOW_EXAMPLES.md`: read-only workspace audit, draft-only campaign, and preflight/scheduling recipes.
- `mcp.json`: one remote Streamable HTTP server definition and OAuth/API-key discovery notes.

The MCP server currently exposes 46 tools, 7 static resources, 4 authenticated workspace resource templates, and 9 prompts. Discover live definitions after connecting. Client config formats differ; use the URL and Streamable HTTP transport from `mcp.json` in the client's remote-server settings rather than assuming the whole file is accepted unchanged. Read workspace context before private actions and get explicit confirmation before publishing. Inbox replies also require explicit confirmation; Hoxi suggestions are drafts only. ChatGPT uses its dedicated `vismatix-chatgpt-plugin.zip` package.

Need the guide by itself? Download `VISMATIX_FULL_GUIDE.md` from `https://vismatix.online/docs/agent-pack/VISMATIX_FULL_GUIDE.md`; it is identical to the copy in this ZIP.

## Security

OAuth is the recommended sign-in. `vmtx_u_*` keys are account scoped; `vmtx_p_*` keys are restricted to one project and cannot access another. Never put an actual key in this archive, source control, a shared prompt, or chat history. The `mcp.json` file contains public endpoints and authentication metadata only.