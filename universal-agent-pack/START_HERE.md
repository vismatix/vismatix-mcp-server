# Start Here — Vismatix Universal Agent Pack

This bundle is designed to connect first and load detailed knowledge only when it is useful.

## 1. Connect

- Add the `vismatix` remote MCP server from `mcp.json` in your client's MCP settings. Use the Streamable HTTP endpoint `https://vismatix.online/mcp`.
- Choose OAuth 2.1 sign-in when the client offers it. Vismatix discovers OAuth 2.1 authorization-code flow with PKCE S256 from `https://vismatix.online/.well-known/oauth-authorization-server` and protected-resource metadata at `https://vismatix.online/.well-known/oauth-protected-resource/mcp`.
- A compatible client may instead use a Bearer API key through its secure credential store. `vmtx_u_*` is account-scoped; `vmtx_p_*` is confined to one project. Never paste a real key into chat, a prompt, or a shared configuration file.
- Client configuration formats vary. Copy the endpoint and transport into the client's remote HTTP MCP settings; treat the extra authentication fields in `mcp.json` as reference metadata if the client requires a strict config schema.

## 2. Keep the agent context small

- Keep `AGENTS.md` loaded for the short operating rules.
- Load `SKILL.md` when using MCP tools, resources, or workflow prompts.
- Search `VISMATIX_FULL_GUIDE.md` for the product topic at hand; load the complete file only when needed. You can also read `vismatix://docs/full-guide` from the live server.
- Use `WORKFLOW_EXAMPLES.md` for safe, repeatable operating sequences.

## 3. First conversation

Ask the agent to identify the Vismatix account and list the workspaces available to you. Select the intended workspace, then review its snapshot, Brand Kit, matrix, or readiness report before proposing changes. The MCP server publishes current schemas through `tools/list`, `resources/list`, `resources/templates/list`, and `prompts/list`; those live definitions are authoritative.

## 4. Safe operating defaults

- A draft is not scheduled, and a scheduled post is not published.
- Create drafts only when requested. Schedule only when the user requests scheduling and has reviewed the target content and slots.
- Obtain explicit confirmation before publishing. Respect plan limits, project scope, channel health, team approvals, and verification checkpoints.
- Report IDs and outcomes only when confirmed by tool responses. Do not retry a mutation when its result is uncertain.

Product docs and downloads: `https://vismatix.online/docs/developer/agents`.