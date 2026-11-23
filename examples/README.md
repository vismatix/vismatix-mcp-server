# Vismatix MCP v3.3.0 and REST API v3 examples

These examples target the production Streamable HTTP endpoint at `https://vismatix.online/mcp` and use OAuth 2.1 + PKCE when the client supports browser sign-in. The server currently exposes 53 MCP tools, 7 static resources, 4 authenticated workspace resource templates, and 9 prompts; discover live schemas after connecting. Store API keys in a local credential manager and expose them to scripts through environment variables.

- `cursor-mcp.json`, `vscode-mcp.json`, `codex-config.toml`, and `mcp-client-config.json` show client connection settings.
- `claude-code-setup.sh` adds the authenticated and public documentation endpoints.
- `mcp-v33-protocol-smoke.sh` checks public JSON initialization and the empty HTTP 202 notification response.
- `api-v3-quickstart.sh` demonstrates authenticated REST API v3 reads using `VISMATIX_API_KEY`.

The remote server supports JSON-RPC requests and batches, JSON/SSE `Accept` negotiation, and MCP session handling. See the root README for OAuth discovery, client setup, agency collaboration, and current tools, resources, and prompts.
