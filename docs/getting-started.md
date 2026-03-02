# Getting Started with ShopClaw AI

## What is ShopClaw AI?

ShopClaw AI is a ready-to-use AI customer service solution for e-commerce stores. It automatically responds to customer inquiries about products, orders, promotions, and policies across multiple messaging channels.

**Built on [OpenClaw](https://openclaw.ai)** — the open-source AI assistant platform.

## Prerequisites

- **Node.js 22+** — [Download here](https://nodejs.org/)
- **An LLM API key** — Either [Anthropic](https://console.anthropic.com/) or [OpenAI](https://platform.openai.com/)
- **A messaging channel** — Zalo OA, Telegram Bot, WhatsApp Business, or others

## Quick Setup (5 minutes)

### 1. Clone the repository

```bash
git clone https://github.com/hohuyblon-stack/openclaw.git shopclaw
cd shopclaw
```

### 2. Run the setup wizard

```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

The wizard will walk you through:
- Installing OpenClaw
- Choosing your AI provider (Claude or GPT-4)
- Connecting messaging channels
- Selecting a store template

### 3. Add your products

Edit `data/products.json` with your actual product catalog, or use the product manager:

```bash
chmod +x scripts/manage-products.sh
./scripts/manage-products.sh add        # Add a product
./scripts/manage-products.sh list       # List all products
./scripts/manage-products.sh validate   # Validate catalog
```

### 4. Configure your channel credentials

Edit the relevant config file in `config/channels/`:

- **Zalo:** `config/channels/zalo.json` — Get credentials from [Zalo Developer](https://developers.zalo.me)
- **Telegram:** `config/channels/telegram.json` — Get bot token from [@BotFather](https://t.me/BotFather)
- **WhatsApp:** `config/channels/whatsapp.json` — Set up via [Meta Business](https://business.facebook.com)
- **Messenger:** `config/channels/messenger.json` — Set up via [Meta Developer](https://developers.facebook.com)

### 5. Start ShopClaw AI

```bash
openclaw start
```

That's it! Send a test message to your bot and watch it respond.

## Docker Setup

If you prefer Docker:

```bash
# Set your API key
export ANTHROPIC_API_KEY=your-key-here

# Start
cd docker
docker-compose up -d

# View logs
docker-compose logs -f

# Stop
docker-compose down
```

## Testing Your Setup

1. Open your messaging app (Telegram, Zalo, etc.)
2. Send a message to your bot
3. Try these test messages:
   - "Có áo thun trắng không?" (Product inquiry)
   - "Kiểm tra đơn ORD-20260228-001" (Order tracking)
   - "Có mã giảm giá nào không?" (Promotions)
   - "Chính sách đổi trả?" (Policies)

## Customization

See [Customization Guide](customization.md) for:
- Changing the AI's personality and tone
- Adding custom policies
- Configuring for your specific industry
- Setting up escalation to human agents

## Troubleshooting

**Bot not responding?**
- Run `openclaw doctor` to check configuration
- Verify your API key is correct
- Check channel credentials

**Wrong answers?**
- Update `data/products.json` with accurate product info
- Customize `workspace/SOUL.md` for your brand voice
- Edit `skills/faq-policy/SKILL.md` with your actual policies

**Need help?**
- OpenClaw docs: https://docs.openclaw.ai
- ShopClaw community: Join our Discord
