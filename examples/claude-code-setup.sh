#!/usr/bin/env bash
set -euo pipefail

# Vismatix MCP Server v3.3.0.

# Option 1 (Recommended): Add Vismatix remote MCP with OAuth 2.1 + PKCE (S256)
claude mcp add --transport http vismatix https://vismatix.online/mcp

# Option 2: Add zero-auth public pre-login documentation & device-login server
claude mcp add --transport http vismatix-public https://vismatix.online/mcp/public

# Option 3: Use an API key from https://vismatix.online/settings/api or /agentauth
# export VISMATIX_API_KEY="vmtx_u_YOUR_API_KEY"
# claude mcp add --transport http vismatix https://vismatix.online/mcp \
#   --header "Authorization: Bearer ${VISMATIX_API_KEY}"

# Optional: Install Vismatix Agent Skill & Cheat Sheet into project .claude/skills/vismatix/
# mkdir -p .claude/skills/vismatix
# curl -sSf "https://vismatix.online/docs/agent-pack?target=skill&inline=1" -o .claude/skills/vismatix/SKILL.md
