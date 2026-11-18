#!/usr/bin/env bash
set -euo pipefail

BASE_URL="https://vismatix.online/api/v3"
API_KEY="vmtx_u_YOUR_API_KEY"

# Public health check; no API key required.
curl --fail-with-body --silent --show-error \
  "${BASE_URL}/health"

# Verify the account/project identity associated with the placeholder key.
curl --fail-with-body --silent --show-error \
  --header "Accept: application/json" \
  --header "Authorization: Bearer ${API_KEY}" \
  "${BASE_URL}/me"

# List posts. Replace the placeholder with a key stored in your local secret
# manager; never commit a real key to source control.
curl --fail-with-body --silent --show-error \
  --header "Accept: application/json" \
  --header "Authorization: Bearer ${API_KEY}" \
  "${BASE_URL}/posts"
