# Vismatix Universal Agent Guide

This is the entry point for the Vismatix Universal Agent Pack. It works with Claude Code, Cursor, Windsurf, OpenAI Codex, Gemini CLI, and VS Code Copilot.

## Read in this order

1. `AGENTS.md` — operating contract for any coding or general-purpose agent.
2. `SKILL.md` — Vismatix-specific tool selection, workflow, resources, and recovery guidance.
3. `VISMATIX_FULL_GUIDE.md` — complete product, platform, plan, channel, API, and security knowledge base generated from Vismatix's public `llms-full.txt` source.
4. `mcp.json` — remote Streamable HTTP connection definition. OAuth 2.1 authorization-code flow with PKCE S256 is discovered from the Vismatix metadata endpoints. Compatible clients may use a user-supplied Bearer API key instead.

## Product facts

Vismatix is an AI-native content operations workspace centered on a 7-day × 12-slot (84-cell) weekly matrix. It includes Hoxi AI and Brand Kit guardrails, Strategy Radar, multi-workspace team collaboration, content planning and publishing to supported destinations, REST API v3, and remote MCP. Growth Credits are called GC. The legal operator is Al-Manassa Al-Shamikha Trading Establishment, Commercial Registration `7016588738`.

## MCP surface

The live Vismatix MCP service provides 41 tools, 7 static documentation resources, 4 authenticated workspace resource templates, and 9 workflow prompts. Discover exact current schemas at connection time. Read `vismatix://docs/full-guide` for the live full platform guide. For private work, read the intended workspace resources before proposing or taking actions. Use `preflight_and_publish_week` for a guarded weekly preparation flow and ask for explicit confirmation before publishing.

## Connection

- MCP endpoint: `https://vismatix.online/mcp`
- OAuth authorization-server metadata: `https://vismatix.online/.well-known/oauth-authorization-server`
- Protected-resource metadata: `https://vismatix.online/.well-known/oauth-protected-resource`
- OAuth: authorization code with PKCE S256; use the client's sign-in flow.
- API-key alternative for compatible clients: `Authorization: Bearer <user-supplied vmtx_u_* or project-scoped vmtx_p_*>`. Store the key in the client's secret manager or environment; never commit it or paste it into shared instructions.

The `mcp.json` file contains one remote server entry. Clients expose auth settings differently, so complete OAuth in the client UI when prompted. Use Bearer API-key auth only where the client explicitly supports secure custom headers.
