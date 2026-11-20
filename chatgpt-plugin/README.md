# Vismatix ChatGPT Plugin

This ZIP uses the portable OpenAI Agent Plugins layout (`plugin.json`, `mcp.json`, `skills/`, and `assets/`). Begin with `PLUGIN_PROMPT.md` for the system/domain manual, then consult `VISMATIX_FULL_GUIDE.md` for complete current product and developer knowledge.

The same guide is available as a standalone Markdown download at `https://vismatix.online/docs/agent-pack/VISMATIX_FULL_GUIDE.md` for direct use without unzipping.

## English setup

1. In ChatGPT on the web, open the Plugins area for the intended workspace. If **Upload plugin** is available and you have upload permission, choose **Add → Upload plugin** and select this ZIP. Upload access and custom MCP availability are controlled by ChatGPT plan, workspace policy, and administrator permissions.
2. Enable the Vismatix plugin. If ChatGPT asks you to add or configure its MCP server, use `https://vismatix.online/mcp`, select OAuth, and complete the Vismatix sign-in and consent flow. The authorization server publishes PKCE S256, CIMD, and DCR discovery at `https://vismatix.online/.well-known/oauth-authorization-server`.
3. Start a new chat and ask Vismatix to inspect a workspace you can access. Workspace operations remain subject to Vismatix plan, scope, and approval rules.

If your ChatGPT account does not show plugin ZIP upload or custom MCP connectors, ask the workspace administrator whether they are enabled. OpenAI currently restricts new custom GPT creation on personal accounts; this ZIP is a portable Plugin package, not a Custom GPT builder or GPT Actions import. ChatGPT's hosted MCP connection uses OAuth and does not currently send customer-supplied API keys. The included `mcp-api-key.json` is for compatible MCP clients that support Bearer API keys; create and scope a key in Vismatix settings, never paste it into chat, and keep it out of shared files.

This is a portable MCP plugin package, not the retired legacy ChatGPT Plugins Store format and not a GPT Actions OpenAPI import. An official directory listing is separate from importing a ZIP.

## الإعداد باللغة العربية

1. افتح ChatGPT على الويب ثم مساحة الإضافات في مساحة العمل المقصودة. إذا ظهر خيار **Upload plugin** وكانت لديك صلاحية الرفع، اختر **Add → Upload plugin** وحدد ملف ZIP. يعتمد توفر الرفع وخوادم MCP المخصصة على الخطة وسياسات مساحة العمل وصلاحيات المسؤول.
2. فعّل إضافة Vismatix. إذا طلب ChatGPT إعداد خادم MCP، استخدم `https://vismatix.online/mcp` واختر OAuth، ثم أكمل تسجيل الدخول والموافقة لدى Vismatix. ينشر خادم التفويض اكتشاف PKCE S256 وCIMD وDCR على `https://vismatix.online/.well-known/oauth-authorization-server`.
3. ابدأ محادثة جديدة واطلب من Vismatix فحص مساحة عمل تملك صلاحية الوصول إليها. تظل عمليات مساحة العمل خاضعة للخطة والنطاقات وقواعد الموافقة في Vismatix.

إذا لم يظهر في حساب ChatGPT خيار رفع ZIP أو موصل MCP مخصص، فاسأل مسؤول مساحة العمل عن تفعيله. لا تتيح OpenAI حالياً إنشاء GPT مخصص جديد من الحسابات الشخصية؛ هذه الحزمة إضافة محمولة وليست أداة لإنشاء GPT مخصص أو استيراد GPT Actions. يستخدم اتصال MCP المستضاف في ChatGPT OAuth ولا يرسل حالياً مفاتيح API التي يقدمها العملاء. ملف `mcp-api-key.json` مخصص لعملاء MCP المتوافقة التي تدعم مفاتيح Bearer؛ أنشئ مفتاحاً محدود الصلاحيات من إعدادات Vismatix، ولا تلصقه في المحادثة أو تشاركه في الملفات.

هذه حزمة إضافة MCP محمولة، وليست صيغة ChatGPT Plugins Store القديمة المتوقفة ولا استيراد OpenAPI لإجراءات GPT. نشرها في الدليل الرسمي منفصل عن رفع ZIP.

## Package contents

- `plugin.json`: portable plugin identity and ChatGPT presentation metadata.
- `mcp.json`: Streamable HTTP connector with OAuth 2.1/CIMD and least-privilege scopes.
- `mcp-api-key.json`: optional Bearer-key configuration for compatible MCP clients.
- `PLUGIN_PROMPT.md`: system/domain manual for Vismatix product knowledge, MCP tool/resource/prompt selection, language behavior, and safe workflows.
- `VISMATIX_FULL_GUIDE.md`: full dynamically generated Vismatix Platform Guide based on the `/llms-full.txt` knowledge base.
- `skills/setup/SKILL.md`: connection and workflow safety instructions.
- `icon.svg` and `assets/icon.png`: Vismatix's official square brand mark in SVG and PNG formats.
- `manifest.json`, `chatgpt-app-manifest.json`, and `mcp-connector.json`: readable Vismatix metadata and connector reference.

Operator: Al-Manassa Al-Shamikha Trading Establishment, CR `7016588738`. Support: support@vismatix.online. Privacy: https://vismatix.online/privacy. Terms: https://vismatix.online/terms.
