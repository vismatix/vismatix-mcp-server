#!/usr/bin/env bash
set -euo pipefail

# Vismatix REST API v3 example; use OAuth through MCP for supported remote clients.

BASE_URL="https://vismatix.online/api/v3"
API_KEY="${VISMATIX_API_KEY:?Set VISMATIX_API_KEY using your local credential manager}"

# Public health check; no API key required.
curl --fail-with-body --silent --show-error \
  "${BASE_URL}/health"

# Verify the account/project identity associated with the key.
curl --fail-with-body --silent --show-error \
  --header "Accept: application/json" \
  --header "Authorization: Bearer ${API_KEY}" \
  "${BASE_URL}/me"

# List posts. Never place a real key in source control or paste it into chat.
curl --fail-with-body --silent --show-error \
  --header "Accept: application/json" \
  --header "Authorization: Bearer ${API_KEY}" \
  "${BASE_URL}/posts"
