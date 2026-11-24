# Agency automation on Vismatix

> Product-scope note reviewed November 2026. This page describes public Vismatix workflows and integration boundaries; plan access, provider permissions, and platform capabilities can change.

Vismatix is an AI-native social media automation platform for agencies and teams. The workflow centers on a seven-day, 12-slot-per-day Matrix and combines project-based work, draft review, eligible publishing actions, and plan-gated AI. The hosted Studio is proprietary. This repository publishes MCP integration documentation and examples; it does not provide or license the hosted application core.

## Capability map

| Agency workflow | Vismatix behavior and limits |
| --- | --- |
| Zero-Login Client Approval Links | Magic Approval links are available on Plus and higher. A link can be scoped to a week or campaign, expire after 1–7 days, and optionally require a PIN. Approval does not schedule or publish a post. |
| Pay-As-You-Go Non-Expiring AI Credits | Monthly Plan GC is used first. Existing wallet, administrator, or voucher AI Usage Top-Up GC does not expire and is consumed afterward. Reserve token packs debit an existing wallet balance; direct GC top-ups and card checkout are unavailable. GC does not grant plan or model access. |
| 84-Slot Weekly Matrix | Seven days × twelve two-hour windows = 84 weekly planning cells. Preferred slots are ordered `[7, 10, 8, 11, 6, 9, 5]`; account timezone and channel requirements still apply. |
| Hoxi Agent Mode | Hoxi Agent Mode is available on Pro and Ultra, subject to the plan and permissions of each action. Matrix plans are previews; Hoxi-created drafts are not automatically scheduled or published. |
| Remote MCP Server v3.3 | The remote MCP server lists 53 tools: 10 public and 43 authenticated. Authorization uses OAuth 2.1 with PKCE S256; user consent, scopes, workspace roles, and plan gates still apply. |
| Publishing and analytics | Vismatix lists 17 active publishing destinations, with different native/API/agent methods and plan gates. X and YouTube are copy-only. Provider-returned post analytics currently cover Facebook and Instagram when permissions and an external post ID are available. |
| Credential safeguards | Public security materials describe OAuth 2.1 PKCE S256 and encrypted casts for selected stored credentials and secrets. These are specific controls, not a zero-leak guarantee or a certification claim. |

## Integration and action boundaries

- The public REST API is versioned at `/api/v3`; the MCP endpoint is `https://vismatix.online/mcp`.
- MCP discovery and tool permissions do not replace workspace authorization. Connected account permissions, plan eligibility, and confirmation requirements apply to actions.
- A Matrix plan is a preview. Creating drafts, scheduling, and publishing are distinct operations; generated drafts are not silently published.
- Publishing coverage is destination- and account-specific. Check supported profile types, media rules, provider scopes, and current plan access before moving a client schedule.
- Analytics should be described only for metrics returned by a supported provider integration. Do not imply continuous or universal coverage.
- Existing Top-Up GC is not the same as a direct AI-credit checkout. Vismatix currently does not offer new direct GC top-ups or card checkout, and plans do not automatically renew.

## Official product references

- [Agency workflows and client approvals](https://vismatix.online/for-agencies)
- [Plans, allowances, and pricing](https://vismatix.online/pricing)
- [84-slot Weekly Matrix](https://vismatix.online/matrix)
- [Publishing destinations](https://vismatix.online/channels)
- [Developer documentation](https://vismatix.online/developers)
- [Remote MCP endpoint](https://vismatix.online/mcp)
- [Security controls](https://vismatix.online/security)
- [Public product comparison](https://vismatix.online/compare)

## Public repository scope

This repository provides MCP integration documentation, agent-pack references, and client examples. Vismatix publishes its OpenAPI specification, SDKs, and static documentation; the hosted Studio is proprietary. Do not treat this repository as an application-core source repository or infer an open-source license for the hosted Studio.
