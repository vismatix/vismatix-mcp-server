---
name: vismatix
description: Use when planning, auditing, repurposing, scheduling, or managing social content, brand voice, and 84-slot weekly matrices on Vismatix via MCP (`https://vismatix.online/mcp`) or REST API v3 (`https://vismatix.online/api/v3`).
---

# Vismatix Autonomous Agent Skill Playbook

> **Production Host:** `https://vismatix.online` | **Environment Root:** `https://vismatix.online`
> **Remote MCP (OAuth 2.1 / Bearer):** `https://vismatix.online/mcp` | **Public Pre-Login Docs MCP:** `https://vismatix.online/mcp/public`
> **Device Portal:** `https://vismatix.online/agentauth` | **REST API v3:** `https://vismatix.online/api/v3`

## 1. Human-First vs Developer Operating Mode
- When answering creators or workspace operators, guide them with Vismatix Studio UI clicks (`Create post`, `Content matrix`, `Kanban`, `Tasks`, `Strategy radar`, `Hoxi Copilot`, `/settings/*`) rather than dumping REST endpoints.
- When running tools or implementing developer integrations, operate via Official MCP (`53` tools) or `/api/v3/*` (`Idempotency-Key` on applicable mutations).

## 2. Authentication Quickstart
1. **OAuth 2.1 + PKCE `S256` (CIMD & DCR):** Connect to `https://vismatix.online/mcp` (discovery at `https://vismatix.online/.well-known/oauth-protected-resource/mcp`).
2. **Device Code Flow:** Call `vismatix_begin_device_auth`, send the user to `https://vismatix.online/agentauth` with the 8-character `user_code`, then poll `vismatix_poll_device_auth`.
3. **API Keys:** Send `Authorization: Bearer vmtx_u_...` (account master) or `vmtx_p_...` (single-project locked). Always call `vismatix_get_identity` when scope is unknown.

## 3. Authenticated Workspace Resource Templates
Read these before drafting or batch-scheduling to ground output in real workspace state:
- `vismatix://workspace/{id}/snapshot` (`projects:read`) — post counts, active campaigns, `matrix_gaps.open_prime_coordinates`, pending tasks, recent ideas, and channels.
- `vismatix://workspace/{id}/matrix/week` (`matrix:read`) — weekly 7x12 occupancy summary, occupied slots, and open Golden Peak coordinates (`PRIME_SLOTS = [7, 10, 8, 11, 6, 9, 5]`).
- `vismatix://workspace/{id}/brand-voice` (`projects:read`) — project description, voice persona, target audience, tone rules, `forbidden_words`, Arabic register, signature, and hashtag vault.
- `vismatix://workspace/{id}/readiness-report` (`projects:read`) — channel connection metadata, upcoming failed/stuck scheduled posts, Brand Kit completeness, and open Golden Peak slots for the next seven days.

## 3A. Hoxi Copywriting & Brand Preflight
- Native formats include X single posts and threads (copy only), LinkedIn thought leadership and B2B stories, Instagram captions/carousels, TikTok/Reels/Shorts scripts, Facebook posts, YouTube descriptions (copy only), and long-form SEO articles.
- Match English, Arabic, Spanish, French, or German. Arabic registers include commercial Saudi/Gulf, Modern Standard Arabic, and Egyptian Arabic.
- Apply the current workspace Brand Kit and recent/scheduled post memory to every generation or rewrite. Use three-hook, selected-channel adaptation, tone/dialect, carousel, thread, and short-video transformations. Review the returned Brand Alignment score/note; it is not a factual or legal approval guarantee.
- A seven-day campaign uses educational, storytelling, social-proof, product/offer, and engagement pillars. Applying a plan creates up to 15 draft-only posts in open Golden Peak slots with access, plan, conflict, channel, Brand Kit, and length checks. It does not schedule or publish.

## 3B. Unified Social Inbox
- Read conversations only in the authenticated workspace using `inbox_list_threads` and `inbox_get_thread`; Hoxi options from `inbox_ai_suggest_replies` are drafts and require Brand Kit review.
- Internal notes are private workspace records. An outbound reply requires clear user approval before calling `inbox_reply` with `confirm_send=true`; it may remain queued if the provider or reply capability is unavailable.
- Use `inbox_convert_to_post` to create a privacy-safe Matrix draft from a customer question. It does not schedule or publish.
- Provider events enter through configured normalized adapters or the signed Vismatix webhook relay. Do not claim automatic polling for a platform unless the live workspace reports that connection.

## 4. Composable Workflow Prompts (`prompts/get`)
- Agency workspaces on Plus, Pro, and Ultra can use isolated Client Reviewer access with revocable week- or campaign-scoped approval links and optional PIN protection. The review portal exposes only scoped content.
- Brand DNA extraction proposes a draft profile from a public website for review. First-week onboarding reuses existing Matrix planning and draft workflows; applying plans creates drafts only.
- `hoxi_generate_matrix_plan` is a preview only; `hoxi_draft_inbox_reply` creates unsent reply options; `hoxi_repurpose_winner` requires explicit approval and creates drafts only. None of these tools schedules or publishes content.
- `weekly_content_sprint` — read workspace snapshot + brand voice, fill open Golden Peak gaps, score via `vismatix_virality_audit`, and stage draft-only posts.
- `brand_audit_and_realign` — audit queued drafts against `brand_kit.forbidden_words`, platform character caps, and tone rules.
- `campaign_matrix_fill` — distribute multi-channel campaign pillars across unoccupied weekly slots within `+60 minutes` to `+12 months`.
- `cross_channel_repurpose` — adapt flagship copy across active publishing destinations (`17` active channels); X and YouTube copy formats do not publish through Vismatix.
- `preflight_and_publish_week` — inspect the readiness report, audit scheduled posts, propose brand/length fixes, and schedule approved drafts only after confirmation.
- Core onboarding & utility prompts: `human-studio-companion`, `agent-auth-onboarding`, `weekly-content-planner`, `geo-article-auditor`.

## 5. Self-Correcting Validation & Error Recovery
- Tool validation (`INVALID_PARAMS`) returns `invalid_fields` and a concrete `recovery_hint` (including allowed enums or required IDs).
- `FORBIDDEN_PROJECT_KEY` — switch from `vmtx_p_` to `vmtx_u_` for account/wallet/webhook/preset/audit/AI paths, or omit mismatched `project_id`.
- `AI_API_ACCESS_DISABLED` — external API keys require admin verification on `/api/v3/ai/*`; use deterministic `vismatix_virality_audit` and `vismatix_geo_analyze`.
- `VALIDATION_ERROR` — ensure `scheduled_datetime` is `+60 minutes` to `+12 months` ahead in user timezone with valid platform constraints.
