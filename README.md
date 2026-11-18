# Vismatix MCP Server

Official public integration documentation and client examples for connecting AI assistants and developer tools to Vismatix.

Vismatix is an AI-native content operations and multi-channel publishing platform. Its workspace includes a 7-day × 12-slot (84-cell) Weekly Matrix, Strategy Radar, Hoxi Copilot, and publishing workflows for supported social destinations. The hosted Workspace Studio is proprietary. This repository publishes integration documentation and examples; it does not contain or license the hosted application core.

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
- Server version: `3.1.0`
- Default protocol version: `2025-03-26`; supported versions: `2025-11-25`, `2025-06-18`, `2025-03-26`, and `2024-11-05`.

The authenticated endpoint initiates OAuth when a client connects without a bearer credential. OAuth discovery is available at:

- Protected resource metadata: <https://vismatix.online/.well-known/oauth-protected-resource>
- Authorization server metadata: <https://vismatix.online/.well-known/oauth-authorization-server>

Vismatix supports OAuth 2.1 Authorization Code with PKCE `S256`, OAuth Dynamic Client Registration (DCR), Client ID Metadata Documents (CIMD), refresh-token rotation, revocation, and granular user consent. OAuth endpoints are:

- Register client: `POST https://vismatix.online/oauth/register`
- Authorize: `GET https://vismatix.online/oauth/authorize`
- Exchange or refresh token: `POST https://vismatix.online/oauth/token`
- Revoke token: `POST https://vismatix.online/oauth/revoke`

The supported OAuth scopes are `profile:read`, `projects:read`, `projects:write`, `posts:read`, `posts:write`, `posts:publish`, `matrix:read`, `matrix:write`, `tasks:read`, `tasks:write`, `analytics:read`, `webhooks:manage`, `wallet:read`, `wallet:transfer`, `ai:use`, and `offline_access`. Review the consent screen and grant only the access needed for your workflow. Workspace plan and role checks still apply.

For terminal or headless clients, the optional device flow uses <https://vismatix.online/agentauth>. The agent starts a device request, shows the human an 8-character code to approve, then polls for the credential. The flow can issue an account key (`vmtx_u_`) or a single-project key (`vmtx_p_`). The account key has broader account authority; the project key is restricted to its project. Treat issued credentials as secrets and store them in your client’s secure credential store.

### Claude Desktop

Claude Desktop connects to remote MCP servers through its Connectors settings; remote connectors should not be added to `claude_desktop_config.json`.

1. Open **Settings → Connectors**.
2. Choose **Add custom connector** (for Team or Enterprise, an owner may need to enable it first).
3. Enter a name such as `Vismatix` and the URL `https://vismatix.online/mcp`.
4. Add the connector, choose **Connect**, and complete Vismatix’s OAuth sign-in and scope approval.
5. Enable only the tools needed in the chat’s tools menu.

Claude’s connector availability depends on the Claude plan and workspace policy. See [Anthropic’s remote MCP connector guide](https://support.anthropic.com/en/articles/11175166-about-custom-integrations-using-remote-mcp).

### Cursor

Cursor supports remote Streamable HTTP MCP servers with OAuth. Add a server from **Cursor → Settings → Tools & Integrations → MCP** or create `.cursor/mcp.json` in a project. A minimal DCR configuration is:

```json
{
  "mcpServers": {
    "vismatix": {
      "url": "https://vismatix.online/mcp"
    }
  }
}
```

Cursor will discover the OAuth metadata and run the authorization flow. If your integration has a pre-registered static OAuth client, the optional `auth.CLIENT_ID` field shown in [`examples/mcp-client-config.json`](examples/mcp-client-config.json) is a placeholder to replace. Vismatix supports DCR/CIMD; remove the `auth` object to use client registration instead of static credentials. Do not invent a client ID or commit a client secret.

See [Cursor’s MCP documentation](https://cursor.com/docs/mcp).

### Codex CLI

Codex CLI accepts a remote MCP URL and can open the browser-based OAuth flow:

```sh
codex mcp add vismatix --url https://vismatix.online/mcp
codex mcp login vismatix
codex mcp list
```

Approve the requested Vismatix scopes in the browser. Alternatively, use the optional `/agentauth` device flow if the client environment is headless. Codex configuration is local to the user and should not be committed with credentials.

### ChatGPT

To add a custom MCP server in ChatGPT, use the custom MCP server/plugin connection controls available to your account or workspace:

1. Open **Plugins** and choose **Add custom MCP server**.
2. Set the public HTTPS server URL to `https://vismatix.online/mcp`.
3. Select OAuth authentication, review the tool list, then create and install the connection.
4. Complete OAuth and review the requested Vismatix scopes before using tools.

Workspace permissions and available UI can vary by account. See [OpenAI’s custom MCP server guide](https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt).

## MCP tools

The server advertises 37 tools. Ten tools support pre-login discovery or setup; account and workspace actions require authorization. Public availability is still subject to endpoint and tool-specific limits.

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

`vismatix_audit_and_health` also exposes public `health` and `geo_guidelines` operations; other operations are subject to authentication and authorization.

### Resources

| URI | Resource |
| --- | --- |
| `vismatix://guide/agent-pack` | Complete Agent Pack handbook and UI guide |
| `vismatix://guide/quick` | Compact agent quick reference |
| `vismatix://guide/llms` | `llms.txt` discovery index |
| `vismatix://docs/handbook-all` | Compiled 13-guide user handbook |
| `vismatix://docs/studio-ui-map` | Workspace UI map JSON |
| `vismatix://api/openapi` | OpenAPI 3.1.0 specification |

### Prompts

- `human-studio-companion`
- `agent-auth-onboarding`
- `weekly-content-planner`
- `geo-article-auditor`

The authoritative, current tool schemas and descriptions are returned by the live `tools/list` method. See [the developer guide](https://vismatix.online/docs/developer/agents) for client setup and authentication details.

## REST API v3

The REST API base URL is `https://vismatix.online/api/v3`. The OpenAPI 3.1.0 document is available at <https://vismatix.online/openapi.json> and <https://vismatix.online/api/v3/openapi.json>; the interactive docs and sandbox are linked from <https://vismatix.online/docs>.

API keys can be sent as `Authorization: Bearer …` or `X-API-Key`. Account keys start with `vmtx_u_`; project keys start with `vmtx_p_` and remain restricted to one project. Use a project key when an integration needs only one workspace. Mutations may require an `Idempotency-Key`; use the operation-specific contract in OpenAPI. New API keys should be stored in a secret manager or local credential store and must never be checked into source control.

A quick `curl` example is available in [`examples/api-v3-quickstart.sh`](examples/api-v3-quickstart.sh). It contains placeholders only.

## Public machine-readable references

- [Developer docs](https://vismatix.online/docs)
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
