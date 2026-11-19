#!/usr/bin/env bash
set -euo pipefail

MCP_URL="https://vismatix.online/mcp/public"

# Public initialize returns the negotiated protocol and a Mcp-Session-Id header.
curl --fail --silent --show-error --output /dev/null --write-out 'Initialize response: HTTP %{http_code}\n' \
  --header "Accept: application/json, text/event-stream" \
  --header "Content-Type: application/json" \
  --data-binary '{"jsonrpc":"2.0","id":"init","method":"initialize","params":{"protocolVersion":"2025-03-26","capabilities":{},"clientInfo":{"name":"v33-smoke","version":"1.0"}}}' \
  "${MCP_URL}"

# Notifications have no JSON-RPC response body and use HTTP 202.
status="$(curl --silent --show-error --output /dev/null --write-out '%{http_code}' \
  --header "Accept: application/json, text/event-stream" \
  --header "Content-Type: application/json" \
  --data-binary '{"jsonrpc":"2.0","method":"notifications/initialized"}' \
  "${MCP_URL}")"
test "${status}" = "202"
printf 'Notification response: HTTP %s with an empty body.\n' "${status}"
