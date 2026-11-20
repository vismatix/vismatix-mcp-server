# Vismatix Workflow Examples

These are operating recipes, not scripts that bypass authorization. Use current MCP schemas and the user's selected workspace.

## 1. Read-only workspace audit

1. Call `vismatix_get_identity` and `vismatix_list_projects`; ask which workspace to inspect if the user has not identified one.
2. Read `vismatix://workspace/{id}/snapshot`, `vismatix://workspace/{id}/matrix/week`, `vismatix://workspace/{id}/brand-voice`, and `vismatix://workspace/{id}/readiness-report` as relevant.
3. Summarize only observed facts: disconnected channels, failed or stuck upcoming posts, Brand Kit gaps, and empty Golden Peak slots.
4. Keep this pass read-only. Present suggested fixes separately and wait for the user to request changes.

## 2. Build a weekly campaign as drafts

This is a draft-only campaign workflow until the user separately approves scheduling or publishing.

1. Confirm the brief, audience, language, target channels, and whether the user wants drafts only or scheduling too.
2. Read the workspace snapshot, Brand Kit, and matrix. Use recent post context to avoid repeating titles and angles.
3. Use `weekly_content_sprint` to develop a diverse seven-day plan. Check each draft with `vismatix_audit_post_readiness` and respect its brand and channel findings.
4. When the user asked for draft creation, use `vismatix_bulk_create_drafts` for up to 15 validated items. Report created post IDs and every skipped item from the result.
5. Draft creation does not schedule or publish. For scheduling, present the proposed dates and Golden Peak slots and obtain the user's approval first.

## 3. Preflight and schedule a week

1. Retrieve `preflight_and_publish_week` and follow its live instructions. Start with the readiness report and upcoming scheduled posts.
2. Run `vismatix_audit_post_readiness` for each relevant post. Explain brand violations, format limits, media gaps, and channel connection problems before editing.
3. Propose copy fixes and open Golden Peak slots. Do not silently change existing copy or move posts.
4. After the user approves the specific edits or schedule, apply them through the appropriate tool. Use `vismatix_smart_fill_matrix` only for eligible, approved drafts and respect conflict, plan, Enterprise, and channel limits.
5. Scheduling is not publishing. Before a publish action, show what will be published and where, then obtain explicit confirmation. Report only the final status returned by Vismatix.

## 4. Triage an Inbox conversation

1. Confirm the intended workspace, then read the thread and its parent-post context with `inbox_get_thread`.
2. Use `inbox_ai_suggest_replies` for Brand Kit-reviewed reply drafts, or add a team-only whisper with `inbox_reply` and `internal_note=true`.
3. Show the exact outbound reply and destination. Call `inbox_reply` with `confirm_send=true` only after the user explicitly approves queueing that message.
4. Explain if delivery remains queued because the connected account or provider capability is unavailable. Never describe a queued reply as sent.
5. If the question should become marketing content, use `inbox_convert_to_post`; review the resulting draft in its Matrix cell. It is not scheduled or published.