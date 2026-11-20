---
name: vismatix
description: Use when planning, auditing, repurposing, scheduling, or managing social content, brand voice, and 84-slot weekly matrices on Vismatix via MCP (`https://vismatix.online/mcp`) or REST API v3 (`https://vismatix.online/api/v3`).
---

# Vismatix Autonomous Agent Skill Playbook

> **Production Host:** `https://vismatix.online` | **Environment Root:** `https://vismatix.online`
> **MCP Server:** `v3.3.0` | **Remote MCP (OAuth 2.1 / Bearer):** `https://vismatix.online/mcp` | **Public Pre-Login Docs MCP:** `https://vismatix.online/mcp/public`
> **Device Portal:** `https://vismatix.online/agentauth` | **REST API v3:** `https://vismatix.online/api/v3`

## 1. Human-First vs Developer Operating Mode
- When answering creators or workspace operators, guide them with Vismatix Studio UI clicks (`Create post`, `Content matrix`, `Kanban`, `Tasks`, `Strategy radar`, `Hoxi Copilot`, `/settings/*`) rather than dumping REST endpoints.
- When running tools or implementing developer integrations, operate via Official MCP (`50` tools, including four measured post-publish analytics tools) or `/api/v3/*` (`Idempotency-Key` UUID v4 on mutations).

## 2. Authentication Quickstart
1. **OAuth 2.1 + PKCE `S256` (CIMD & DCR):** Connect to `https://vismatix.online/mcp` (discovery at `https://vismatix.online/.well-known/oauth-protected-resource`).
2. **Device Code Flow:** Call `vismatix_begin_device_auth`, send the user to `https://vismatix.online/agentauth` with the 8-character `user_code`, then poll `vismatix_poll_device_auth`.
3. **API Keys:** Send `Authorization: Bearer vmtx_u_...` (account master) or `vmtx_p_...` (single-project locked). Always call `vismatix_get_identity` when scope is unknown.

## 3. Authenticated Workspace Resource Templates
Read these before drafting or batch-scheduling to ground output in real workspace state:
- `vismatix://workspace/{id}/snapshot` (`projects:read`) — post counts, active campaigns, `matrix_gaps.open_prime_coordinates`, pending tasks, recent ideas, and channels.
- `vismatix://workspace/{id}/matrix/week` (`matrix:read`) — weekly 7x12 occupancy summary, occupied slots, and open Golden Peak coordinates (`PRIME_SLOTS = [7, 10, 8, 11, 6, 9, 5]`).
- `vismatix://workspace/{id}/brand-voice` (`projects:read`) — project description, voice persona, target audience, tone rules, `forbidden_words`, Arabic register, signature, and hashtag vault.
- `vismatix://workspace/{id}/readiness-report` (`projects:read`) — live channel connection metadata, upcoming failed/stuck scheduled posts, Brand Kit completeness, and open Golden Peak slots for seven days. A `vmtx_p_` key can only read its own workspace.

## 4. Unified Social Inbox
- Use `inbox_list_threads` / `inbox_get_thread` for workspace-scoped conversations and `inbox_ai_suggest_replies` for three Brand Kit-reviewed drafts. Internal notes remain private to the workspace.
- `inbox_reply` requires explicit user confirmation for outbound messages. Current direct reply dispatch supports connected Facebook and Instagram accounts with granted capabilities; unsupported or disconnected delivery remains queued.
- `inbox_convert_to_post` creates a privacy-safe draft in an available Matrix cell. It does not schedule or publish.
- Inbound messages arrive through normalized provider adapters or the signed per-account Vismatix webhook relay. Provider coverage and OAuth permissions vary; do not claim every social channel is connected automatically.

## 5. Composable Workflow Prompts (`prompts/get`)
- `weekly_content_sprint` — read workspace snapshot + brand voice, fill open Golden Peak gaps, score via `vismatix_virality_audit`, and stage posts.
- `brand_audit_and_realign` — audit queued drafts against `brand_kit.forbidden_words`, platform character caps, and tone rules.
- `campaign_matrix_fill` — distribute multi-channel campaign pillars across unoccupied weekly slots within `+60 minutes` to `+12 months`.
- `cross_channel_repurpose` — adapt flagship copy across active publishing destinations (`17` active channels; X and YouTube unsupported).
- `preflight_and_publish_week` — review the readiness report, audit upcoming scheduled posts, suggest safe brand/length corrections, then fill open Golden Peak slots after schedule confirmation.
- Core onboarding & utility prompts: `human-studio-companion`, `agent-auth-onboarding`, `weekly-content-planner`, `geo-article-auditor`.

## 6. v3.3 Agency Workflow Tools
- `vismatix_bulk_create_drafts` validates up to 15 rows, creates valid rows in one transaction, and reports per-item validation skips.
- `vismatix_smart_fill_matrix` schedules eligible approved drafts into open Golden Peak slots; it honors schedule bounds, collisions, approval gates, and Enterprise `matrix_slots` limits.
- `vismatix_audit_post_readiness` checks platform text/media limits, Brand Kit forbidden terms, and locally known channel connection/expiry state. It does not contact social providers.
- `vismatix_get_gc_and_plan_status` shows plan, permitted Enterprise overrides, quota use, and key scopes. Project-scoped credentials do not receive account GC balance or other workspace data.
- JSON-RPC notifications receive an empty HTTP `202`; `Accept` negotiates JSON/SSE, and initialize responses establish a `Mcp-Session-Id`.

## 7. Self-Correcting Validation & Error Recovery
- Tool validation (`INVALID_PARAMS`) returns `invalid_fields` and a concrete `recovery_hint` (including allowed enums or required IDs).
- `FORBIDDEN_PROJECT_KEY` — switch from `vmtx_p_` to `vmtx_u_` for account/wallet/webhook/preset/audit/AI paths, or omit mismatched `project_id`.
- `AI_API_ACCESS_DISABLED` — external API keys require admin verification on `/api/v3/ai/*`; use deterministic `vismatix_virality_audit` and `vismatix_geo_analyze`.
- `VALIDATION_ERROR` — ensure `scheduled_datetime` is `+60 minutes` to `+12 months` ahead in user timezone with valid platform constraints.
