# Vismatix MCP Server

Official public integration documentation, agent skill files, and client examples for connecting AI assistants and IDE/CLI agents to Vismatix.

Vismatix is an AI-native content operations and multi-channel publishing platform centered on a 7-day × 12-slot (84-cell) Weekly Matrix, Strategy Radar, Hoxi Copilot, and publishing workflows across 17 active social destinations (X/Twitter and YouTube are unsupported). The hosted Workspace Studio is proprietary. This repository publishes integration specifications, Agent Pack files, and client examples; it does not contain or license the hosted application core.

## Operator and legal identity

Vismatix is owned and operated by **Al-Manassa Al-Shamikha Trading Establishment** (مؤسسة المنصه الشامخه للتجارة), based in Jeddah, Kingdom of Saudi Arabia.

- Commercial Registration: `7016588738`
- VAT registration: `300090183700003`
- Owner: [owner@vismatix.online](mailto:owner@vismatix.online)
- Support: [support@vismatix.online](mailto:support@vismatix.online)
- Website: <https://vismatix.online>

The operator details and registration identifiers above are published as supplied by Vismatix. This repository does not represent that they have been independently verified by a government registry.

## Connect to the MCP server

- Authenticated production endpoint: <https://vismatix.online/mcp>
- Public pre-login documentation endpoint: <https://vismatix.online/mcp/public>
- Compatibility endpoint aliases: `/api/mcp` and `/api/mcp/public`
- Transport: MCP Streamable HTTP with JSON-RPC 2.0; GET provides discovery, POST handles MCP messages, and DELETE terminates a session.
- Server version: `3.3.0`
- Default protocol version: `2025-03-26`; supported versions include `2026-07-28`, `2025-11-25`, `2025-06-18`, `2025-03-26`, and `2024-11-05`.

The authenticated endpoint initiates OAuth when a client connects without a bearer credential. OAuth discovery is available at:

- Protected resource metadata: <https://vismatix.online/.well-known/oauth-protected-resource>
- Authorization server metadata: <https://vismatix.online/.well-known/oauth-authorization-server>

Vismatix supports OAuth 2.1 Authorization Code with PKCE `S256`, OAuth Dynamic Client Registration (DCR), Client ID Metadata Documents (CIMD), refresh-token rotation, revocation, and granular user consent. OAuth endpoints are:

- Register client: `POST https://vismatix.online/oauth/register`
- Authorize: `GET https://vismatix.online/oauth/authorize`
- Exchange or refresh token: `POST https://vismatix.online/oauth/token`
- Revoke token: `POST https://vismatix.online/oauth/revoke`

The supported OAuth scopes are `profile:read`, `projects:read`, `projects:write`, `posts:read`, `posts:write`, `posts:publish`, `matrix:read`, `matrix:write`, `tasks:read`, `tasks:write`, `analytics:read`, `inbox:read`, `inbox:write`, `webhooks:manage`, `wallet:read`, `wallet:transfer`, `ai:use`, and `offline_access`. Review the consent screen and grant only the access needed for your workflow. Workspace plan and role checks still apply.

The HTTP transport accepts JSON-RPC 2.0 objects and batches, negotiates JSON or Server-Sent Events from `Accept`, and returns `202 Accepted` with an empty body for notifications. An `initialize` response creates a `Mcp-Session-Id`; subsequent responses echo a valid supplied session ID. Keep credentials in the `Authorization: Bearer` header and store them in a secure credential manager.

## Unified Social Inbox

The workspace-scoped Inbox brings normalized DMs, comments, and mentions into one triage queue with assignment, tags, intent/sentiment classification, private team notes, saved replies, teammate presence, and first-response SLA tracking. Threads can be converted into draft-only content in an available Golden Peak Matrix cell. Hoxi suggestions are Brand Kit checked and are never sent automatically.

Inbox API v3 routes include `GET /api/v3/inbox/threads`, `GET /api/v3/inbox/stats`, `GET /api/v3/inbox/threads/{id}`, `GET /api/v3/inbox/threads/{id}/messages`, `POST /api/v3/inbox/threads/{id}/reply`, `POST /api/v3/inbox/threads/{id}/ai-suggest`, `POST /api/v3/inbox/threads/{id}/summarize`, and `POST /api/v3/inbox/threads/{id}/convert-to-post`; inbox paths are documented in `/api/v3/openapi.json`, and the Full Platform Guide lists the complete v3 route catalog. MCP tools are `inbox_list_threads`, `inbox_get_thread`, `inbox_reply`, `inbox_ai_suggest_replies`, and `inbox_convert_to_post`. OAuth scopes are `inbox:read` and `inbox:write` (Hoxi suggestions also require `ai:use`).

Inbound provider events must be normalized and sent to the workspace's signed Vismatix relay at `/api/inbox/provider-webhook/{accountId}`. The relay uses a per-account HMAC secret and replay protection. Provider coverage depends on configured adapters and granted scopes; the current direct outbound reply adapter supports Facebook and Instagram only. Unsupported or disconnected delivery remains queued. Every outbound reply requires explicit user confirmation; private internal notes are not sent to a social provider.

For terminal or headless clients, the optional device flow uses <https://vismatix.online/agentauth>. The agent starts a device request, shows the human an 8-character code to approve, then polls for the credential. The flow can issue an account key (`vmtx_u_`) or a single-project key (`vmtx_p_`). The account key has broader account authority; the project key is restricted to its project. Treat issued credentials as secrets and store them in your client’s secure credential store.

## Post-Publish Engagement Analytics

Vismatix records post-level engagement snapshots and workspace-safe rollups for provider-returned metrics. The API exposes `GET /api/v3/analytics/overview`, `GET /api/v3/analytics/posts`, `GET /api/v3/analytics/heatmap`, `GET /api/v3/analytics/export`, and rate-limited refresh endpoints `POST /api/v3/analytics/sync` and `POST /api/v3/analytics/posts/{post}/sync`. Hoxi post-mortems use `POST /api/v3/analytics/posts/{post}/diagnose` and captured measurements; `POST /api/v3/analytics/posts/{post}/repurpose` creates draft-only content in eligible open Golden Peak Matrix cells and never schedules or publishes.

Current live analytics collection is configured for Facebook and Instagram and requires granted provider permissions and a published external post ID. Unsupported destinations and missing permissions are reported as unavailable; live metrics are not estimated. Deterministic metrics are marked as sandbox data and limited to local/testing environments or explicitly sandbox connections. The measured Matrix heatmap maps engagement back to a post's 7-day × 12-slot position.

## Agency Collaboration and Guided Onboarding

Plus, Pro, and Ultra workspaces support agency collaboration with Owner and Editor roles plus an isolated Client Reviewer role. Review links can be scoped to a week or campaign, optionally protected by a PIN, and revoked. The client review portal shows only the scoped review content—not private workspace, AI, or billing data.

Brand DNA extraction can prepare a draft brand profile from a public website; review suggestions before saving them to the Brand Kit. First-week onboarding helps teams establish brand context, connect eligible channels, and plan in the Matrix. Hoxi reuses the existing planning and draft workflows: applying a plan creates drafts only and never schedules or publishes.

## Agent Packs and Full Platform Guide

Vismatix publishes two primary ZIP bundles plus a standalone Markdown guide, so teams can choose the right format without sorting through per-editor files:

1. **Universal Agent Pack** — [Download `vismatix-agent-pack.zip`](https://vismatix.online/docs/agent-pack/universal-agent-pack.zip). One unified bundle for Claude Code, Cursor, Windsurf, OpenAI Codex, Gemini CLI, and VS Code Copilot. It includes `VISMATIX_FULL_GUIDE.md`, `VISMATIX_AGENT_GUIDE.md`, `AGENTS.md`, `SKILL.md`, a single remote Streamable HTTP `mcp.json`, and setup notes. The generated package source is [`universal-agent-pack/`](universal-agent-pack/).
2. **ChatGPT Plugin** — [Download `vismatix-chatgpt-plugin.zip`](https://vismatix.online/docs/agent-pack/chatgpt-plugin.zip). A dedicated ChatGPT bundle with `plugin.json`, `mcp.json`, `PLUGIN_PROMPT.md`, the complete platform guide, and an English/Arabic setup guide. Its generated package source is [`chatgpt-plugin/`](chatgpt-plugin/).
3. **Standalone Full Platform Guide** — [Download `VISMATIX_FULL_GUIDE.md`](https://vismatix.online/docs/agent-pack/VISMATIX_FULL_GUIDE.md) for a single Markdown manual that can be pasted or uploaded directly into an AI chat, custom project knowledge, or CLI agent without unzipping. The standalone file is kept byte-for-byte identical to the copy embedded in both ZIP bundles. It is also available inline at <https://vismatix.online/llms-full.txt> and live over MCP as `vismatix://docs/full-guide`.

Both bundles include the full Vismatix knowledge base. MCP clients should read `VISMATIX_AGENT_GUIDE.md` or `PLUGIN_PROMPT.md`, then use `VISMATIX_FULL_GUIDE.md` and live schemas. All three options appear together in the Agent Packs section at <https://vismatix.online/docs/developer/agents> and in signed-in AI Connections settings. Existing `/docs/agent-pack?target=...` exports remain available for backward compatibility; they are no longer the primary UI choices.

## Client Setup (30-Second Configs)

Ready-to-copy client configurations and skill playbooks are included in this repository and downloadable directly from <https://vismatix.online/docs/developer/agents>:

- Agent Skill Playbook: [`SKILL.md`](SKILL.md)
- Agent Cheat Sheet & Prompt Contract: [`AGENTS.md`](AGENTS.md)
- Cursor / Windsurf MCP Config: [`examples/cursor-mcp.json`](examples/cursor-mcp.json)
- VS Code Copilot `.vscode/mcp.json`: [`examples/vscode-mcp.json`](examples/vscode-mcp.json)
- Claude Code Setup Script: [`examples/claude-code-setup.sh`](examples/claude-code-setup.sh)
- Codex CLI TOML Config: [`examples/codex-config.toml`](examples/codex-config.toml)
- JSON-RPC v3.3 notification/session smoke example: [`examples/mcp-v33-protocol-smoke.sh`](examples/mcp-v33-protocol-smoke.sh)
- REST API v3 quickstart: [`examples/api-v3-quickstart.sh`](examples/api-v3-quickstart.sh)

### Claude Code

```sh
claude mcp add --transport http vismatix https://vismatix.online/mcp
```

See [`examples/claude-code-setup.sh`](examples/claude-code-setup.sh) for pre-login docs and `VISMATIX_API_KEY` header modes.

### Claude Desktop

Claude Desktop connects to remote MCP servers through its Connectors settings; remote connectors should not be added to `claude_desktop_config.json` manually unless bridging local stdio.

1. Open **Settings → Connectors**.
2. Choose **Add custom connector** (for Team or Enterprise, an owner may need to enable it first).
3. Enter a name such as `Vismatix` and the URL `https://vismatix.online/mcp`.
4. Add the connector, choose **Connect**, and complete Vismatix’s OAuth sign-in and scope approval.
5. Enable only the tools needed in the chat’s tools menu.

See [Anthropic’s remote MCP connector guide](https://support.anthropic.com/en/articles/11175166-about-custom-integrations-using-remote-mcp).

### Cursor & Windsurf

Cursor and Windsurf support remote Streamable HTTP MCP servers with OAuth. Add a server from **Settings → Tools & Integrations → MCP** or save [`examples/cursor-mcp.json`](examples/cursor-mcp.json) as `.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "vismatix": {
      "url": "https://vismatix.online/mcp"
    }
  }
}
```

If your integration has a pre-registered static OAuth client, the optional `auth.CLIENT_ID` field shown in [`examples/mcp-client-config.json`](examples/mcp-client-config.json) is a placeholder to replace. Vismatix supports DCR/CIMD; omit `auth` to use dynamic client registration instead of static credentials. Do not invent a client ID or commit a client secret.

### VS Code (GitHub Copilot / MCP)

Save [`examples/vscode-mcp.json`](examples/vscode-mcp.json) as `.vscode/mcp.json` in your workspace:

```json
{
  "servers": {
    "vismatix": {
      "type": "http",
      "url": "https://vismatix.online/mcp"
    }
  }
}
```

### Codex CLI

Codex CLI accepts a remote MCP URL and opens the browser-based OAuth flow (see [`examples/codex-config.toml`](examples/codex-config.toml)):

```sh
codex mcp add vismatix --url https://vismatix.online/mcp
codex mcp login vismatix
codex mcp list
```

### Gemini CLI

Add `vismatix` in `~/.gemini/settings.json`:

```json
{
  "mcpServers": {
    "vismatix": {
      "httpUrl": "https://vismatix.online/mcp"
    }
  }
}
```

### ChatGPT Plugin ZIP

Use the dedicated [Vismatix ChatGPT Plugin ZIP](https://vismatix.online/docs/agent-pack/chatgpt-plugin.zip) and its generated source files in [`chatgpt-plugin/`](chatgpt-plugin/). It contains `plugin.json`, `mcp.json`, the setup skill, `PLUGIN_PROMPT.md` domain manual, the complete generated `VISMATIX_FULL_GUIDE.md`, and bilingual setup instructions. For Claude Code, Cursor, Windsurf, Codex, Gemini CLI, and VS Code, use the [Universal Agent Pack](https://vismatix.online/docs/agent-pack/universal-agent-pack.zip) instead.

1. In ChatGPT on the web, open the Plugins section for the intended workspace. If **Upload plugin** is available and you have permission, choose **Add → Upload plugin** and select the ZIP.
2. Enable the plugin. If the workspace prompts for an MCP connection, use `https://vismatix.online/mcp`, choose OAuth, and complete Vismatix sign-in and scope consent. OAuth discovery advertises PKCE `S256`, CIMD, and DCR.
3. Start a new conversation and review the tool-approval prompt before any write or publishing action.

ChatGPT controls ZIP-upload and custom-MCP availability by plan, workspace policy, and role. Upload may require an eligible workspace owner or administrator. OpenAI currently does not allow personal accounts to create new custom GPTs; this portable Plugin ZIP is not a legacy ChatGPT Plugin Store package or a GPT Actions OpenAPI import. The hosted ChatGPT MCP connection uses OAuth and does not send user-supplied API keys. [`chatgpt-plugin/mcp-api-key.json`](chatgpt-plugin/mcp-api-key.json) is an alternative for MCP clients that support Bearer API keys; keep keys out of chat and source control.

See [OpenAI’s plugin packaging guide](https://developers.openai.com/plugins/build/plugins), [plugin ZIP upload instructions](https://help.openai.com/en/articles/20001256-plugins-in-chatgpt), and [custom MCP connection guide](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt).

## MCP Capabilities (`v3.3.0`)

- **53 Tools:** 10 pre-login discovery/GEO/auth tools + 43 authenticated workspace, matrix, publishing, AI, Inbox, analytics, wallet, and webhook tools with compact JSON responses and self-correcting `INVALID_PARAMS` / `recovery_hint` guidance.
- **7 Static Documentation Resources** (`resources/list`)
- **4 Authenticated Workspace Resource Templates** (`resources/templates/list`)
- **9 Composable Workflow Prompts** (`prompts/list` & `prompts/get`)

### Pre-login discovery and setup tools

- `vismatix_list_docs`
- `vismatix_read_doc`
- `vismatix_get_plans_and_features`
- `vismatix_get_studio_ui_guide`
- `vismatix_get_auth_instructions`
- `vismatix_begin_device_auth`
- `vismatix_poll_device_auth`
- `vismatix_search_docs`
- `vismatix_list_platforms`
- `vismatix_geo_analyze`

### Authenticated workspace tools

- `vismatix_get_identity`
- `vismatix_get_matrix`
- `vismatix_create_post`
- `vismatix_batch_create_posts`
- `vismatix_move_matrix_post`
- `vismatix_auto_schedule_matrix`
- `vismatix_virality_audit`
- `vismatix_create_idea_or_task`
- `vismatix_list_projects`
- `vismatix_create_project`
- `vismatix_list_posts`
- `vismatix_bulk_mutate_posts`
- `vismatix_manage_post_snapshots`
- `vismatix_apply_template`
- `vismatix_get_analytics`
- `analytics_workspace_overview` — measured workspace engagement KPIs, trend, platform breakdown, and best Matrix slot.
- `analytics_top_posts` — rank published posts by measured rate, reach, comments, shares, clicks, impressions, or engagements.
- `analytics_sync_post` — rate-limited refresh for one accessible published post.
- `analytics_matrix_heatmap` — measured 7×12 Matrix engagement by day and slot.
- `vismatix_webhooks_manage`
- `vismatix_wallet_manage`
- `vismatix_ai_studio_v3`
- `vismatix_manage_account`
- `vismatix_manage_project_members`
- `vismatix_manage_post`
- `vismatix_matrix_controls`
- `vismatix_manage_tasks`
- `vismatix_manage_ideas`
- `vismatix_manage_presets_and_templates`
- `vismatix_manage_notifications`
- `vismatix_audit_and_health`
- `vismatix_bulk_create_drafts` — validate up to 15 drafts independently and create valid rows in one atomic batch.
- `vismatix_smart_fill_matrix` — place eligible drafts into open Golden Peak windows, honoring schedule bounds, plan rules, collisions, and approval gates.
- `vismatix_audit_post_readiness` — check platform character/media rules, forbidden brand terms, and locally known destination connection status.
- `vismatix_get_gc_and_plan_status` — inspect plan, quotas, GC visibility, and credential scopes without exposing tokens.
- `inbox_list_threads`, `inbox_get_thread`, `inbox_reply`, `inbox_ai_suggest_replies`, and `inbox_convert_to_post` — manage workspace-scoped conversations; Hoxi suggestions are drafts, outbound replies require explicit confirmation, and post conversions create drafts only.
- `hoxi_generate_matrix_plan` — preview a Brand Kit-aware seven-day Matrix plan; it does not create or schedule posts.
- `hoxi_draft_inbox_reply` — draft Brand Kit-checked Inbox reply options without sending them.
- `hoxi_repurpose_winner` — after explicit approval, create brand-checked draft variants from measured winners; never schedules or publishes.

`vismatix_audit_and_health` also exposes public `health` and `geo_guidelines` operations; other operations are subject to authentication and authorization.

### Static Resources

| URI | Resource |
| --- | --- |
| `vismatix://guide/agent-pack` | Complete Agent Pack handbook and UI guide |
| `vismatix://guide/quick` | Compact agent quick reference |
| `vismatix://guide/llms` | `llms.txt` discovery index |
| `vismatix://docs/handbook-all` | Compiled 13-guide user handbook |
| `vismatix://docs/full-guide` | Complete generated platform, product, UI, pricing/GC, channel, API, security, and MCP guide |
| `vismatix://docs/studio-ui-map` | Workspace UI map JSON |
| `vismatix://api/openapi` | OpenAPI 3.1.0 specification |

### Authenticated Workspace Resource Templates

| URI Template | Required Scope | Description |
| --- | --- | --- |
| `vismatix://workspace/{id}/snapshot` | `projects:read` | Post status counts, active campaigns, open Golden Peak matrix coordinates, pending tasks, recent ideas, and active channels |
| `vismatix://workspace/{id}/matrix/week` | `matrix:read` | Weekly 7×12 occupancy metrics, occupied slots, and open Golden Peak windows |
| `vismatix://workspace/{id}/brand-voice` | `projects:read` | Workspace brief plus Brand Kit persona, target audience, tone rules, `forbidden_words`, Arabic register, signature, and hashtag vault |
| `vismatix://workspace/{id}/readiness-report` | `projects:read` | Live connection metadata, failed/stuck scheduled items, Brand Kit completeness, and available Golden Peak slots for the next seven days |

### Composable Workflow Prompts

| Prompt Name | Type | Description |
| --- | --- | --- |
| `human-studio-companion` | Companion | Studio-first creator assistance in `ar`, `en`, `es`, `fr`, or `de` |
| `agent-auth-onboarding` | Auth | Step-by-step `/agentauth` 8-character device flow guide |
| `weekly-content-planner` | Planner | Quick matrix gap scan + post creation + scheduling |
| `geo-article-auditor` | GEO | Generative Engine Optimization audit & FAQ/JSON-LD recommendations |
| `weekly_content_sprint` | Workflow | End-to-end sprint reading workspace snapshot & brand voice, checking open 84-slot peaks, scoring hooks, and batch-staging drafts |
| `brand_audit_and_realign` | Workflow | Audits queued drafts/scheduled posts against `brand_kit.forbidden_words`, tone rules, and platform limits |
| `campaign_matrix_fill` | Workflow | Populates multi-channel campaigns across open Golden Peak coordinates within the `+60m..+12m` window |
| `cross_channel_repurpose` | Workflow | Rewrites flagship copy natively per active channel (respecting `17` supported destinations), audits GEO/Virality, and saves drafts |
| `preflight_and_publish_week` | Workflow | Inspect readiness, preflight upcoming posts, propose safe edits, and fill open slots only after schedule confirmation |

The authoritative, current tool schemas and descriptions are returned by the live `tools/list` method. See [the developer guide](https://vismatix.online/docs/developer/agents) for client setup and authentication details.

## REST API v3

The REST API base URL is `https://vismatix.online/api/v3`. The OpenAPI 3.1.0 document is available at <https://vismatix.online/openapi.json> and <https://vismatix.online/api/v3/openapi.json>; the interactive docs and sandbox are linked from <https://vismatix.online/docs>.

API keys can be sent as `Authorization: Bearer …` or `X-API-Key`. Account keys start with `vmtx_u_`; project keys start with `vmtx_p_` and remain restricted to one project. Use a project key when an integration needs only one workspace. Mutations may require an `Idempotency-Key`; use the operation-specific contract in OpenAPI. New API keys should be stored in a secret manager or local credential store and must never be checked into source control.

A quick `curl` example is available in [`examples/api-v3-quickstart.sh`](examples/api-v3-quickstart.sh). It contains placeholders only.

## Public machine-readable references

- [Developer docs](https://vismatix.online/docs)
- [Agent Pack downloads](https://vismatix.online/docs/developer/agents)
- [OpenAPI 3.1.0](https://vismatix.online/openapi.json)
- [`llms.txt`](https://vismatix.online/llms.txt)
- [`llms-full.txt`](https://vismatix.online/llms-full.txt)
- [Security architecture and disclosure](https://vismatix.online/security)
- [GitHub organization](https://github.com/vismatix)

## Public materials and license scope

The public developer materials include the OpenAPI 3.1 specification, Python and JavaScript SDKs, and static documentation. The hosted Workspace Studio is proprietary. This repository’s MIT license applies to the integration specifications and client examples included here; it does not grant a license to the hosted Studio or Vismatix application core.

## Support

- General and account support: [support@vismatix.online](mailto:support@vismatix.online)
- Ownership and business inquiries: [owner@vismatix.online](mailto:owner@vismatix.online)
- Security reports: [security@vismatix.online](mailto:security@vismatix.online)
