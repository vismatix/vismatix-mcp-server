# Vismatix Universal Agent Guide

This is the entry point for the Vismatix Universal Agent Pack. It works with Claude Code, Cursor, Windsurf, OpenAI Codex, Gemini CLI, and VS Code Copilot.

## Read in this order

1. `START_HERE.md` — connect once, choose an authorized workspace, and make your first read-only request.
2. `AGENTS.md` — short operating contract to keep in context for every task.
3. `SKILL.md` — load when you need MCP tools, resources, prompts, or error recovery.
4. `VISMATIX_FULL_GUIDE.md` — the complete product and technical reference. Search by topic and load only relevant sections when context is limited; it is generated from the public `llms-full.txt` source.
5. `WORKFLOW_EXAMPLES.md` — ready-to-follow workspace audit, draft-campaign, and preflight recipes.
6. `mcp.json` — remote Streamable HTTP endpoint plus OAuth/API-key discovery notes.

## Product facts

Vismatix is an AI-native content operations workspace centered on a 7-day × 12-slot (84-cell) weekly matrix. Hoxi writes platform-native copy across major social and long-form formats, uses recent workspace posts to reduce repetition, enforces Brand Kit preflight, and can turn one brief into draft-only weekly campaigns in open Golden Peak slots. It includes Strategy Radar, multi-workspace team collaboration, content planning and publishing to supported destinations, REST API v3, and remote MCP. X and YouTube are writing-only formats, not publishing destinations. Growth Credits are called GC. The legal operator is Al-Manassa Al-Shamikha Trading Establishment, Commercial Registration `7016588738`.

## Post-Publish Engagement Analytics

Published posts can store time-series snapshots and denormalized workspace-safe rollups for impressions, reach, likes, comments, shares, saves, clicks, video views, and engagement rate. The API provides workspace overview, ranked post results, a 7×12 Matrix engagement heatmap, CSV export, rate-limited sync, Hoxi post-mortems, and draft-only winner repurposing. Scheduled collection runs with `vismatix:sync-post-analytics`. Current live provider collection is configured for Facebook and Instagram and requires valid provider permissions plus a published external post ID; unsupported destinations or missing permissions are returned as unavailable, never filled with estimated live metrics. Deterministic sandbox values are labeled and limited to local/testing environments or explicitly sandbox connections. Repurposed content stays a draft in an eligible open Golden Peak Matrix cell; it is never auto-scheduled or published.

## MCP surface

The live Vismatix MCP service provides 50 tools, including `analytics_workspace_overview`, `analytics_top_posts`, `analytics_sync_post`, and `analytics_matrix_heatmap`; it also provides 7 static documentation resources, 4 authenticated workspace resource templates, and 9 workflow prompts. Discover exact current schemas at connection time. Read `vismatix://docs/full-guide` for the live full platform guide. For private work, read the intended workspace resources before proposing or taking actions. Use `preflight_and_publish_week` for a guarded weekly preparation flow and ask for explicit confirmation before publishing. The workspace-scoped Unified Social Inbox tools list/read DMs, comments and mentions, draft Hoxi replies, convert questions into Matrix drafts, and queue outbound replies only after explicit confirmation.

## Connection

- MCP endpoint: `https://vismatix.online/mcp`
- OAuth authorization-server metadata: `https://vismatix.online/.well-known/oauth-authorization-server`
- Protected-resource metadata: `https://vismatix.online/.well-known/oauth-protected-resource/mcp`
- OAuth: authorization code with PKCE S256; use the client's sign-in flow.
- API-key alternative for compatible clients: `Authorization: Bearer <user-supplied vmtx_u_* or project-scoped vmtx_p_*>`. Store the key in the client's secret manager or environment; never commit it or paste it into shared instructions.

The `mcp.json` file contains one remote server entry. Clients expose auth settings differently, so complete OAuth in the client UI when prompted. Use Bearer API-key auth only where the client explicitly supports secure custom headers.
