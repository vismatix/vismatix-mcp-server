# Vismatix MCP v3.3.0 examples

These examples target the production Streamable HTTP endpoint at `https://vismatix.online/mcp` and use OAuth 2.1 + PKCE when the client supports browser sign-in. Store API keys in a local credential manager; the key strings in the examples are placeholders only.

- `cursor-mcp.json`, `vscode-mcp.json`, `codex-config.toml`, and `mcp-client-config.json` show client connection settings.
- `claude-code-setup.sh` adds the authenticated and public documentation endpoints.
- `mcp-v33-protocol-smoke.sh` checks public JSON initialization and the empty HTTP 202 notification response.
- `api-v3-quickstart.sh` demonstrates authenticated REST API v3 reads.

The server supports JSON-RPC requests and batches, JSON/SSE `Accept` negotiation, and `Mcp-Session-Id` propagation. See the root README for OAuth discovery and current tools, resources, and prompts.
