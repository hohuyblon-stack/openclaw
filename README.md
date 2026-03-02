# ShopClaw AI

**AI Customer Service for E-commerce — Powered by OpenClaw**

ShopClaw AI turns your messaging channels into a 24/7 AI-powered customer service agent for your online store. Your customers chat on Zalo, Telegram, WhatsApp, or Messenger — ShopClaw AI responds instantly with product info, pricing, stock availability, shipping details, and return policies.

## Why ShopClaw AI?

- **24/7 Availability** — Never miss a customer inquiry, even at 3 AM
- **Multi-Channel** — Zalo, Telegram, WhatsApp, Facebook Messenger, Discord
- **Multi-Language** — Vietnamese, English, and 50+ languages out of the box
- **Smart Product Knowledge** — Knows your entire catalog: prices, specs, stock levels
- **Order Tracking** — Customers can check order status via chat
- **Customizable** — Add your own FAQs, policies, and brand voice
- **Easy Setup** — One command to get started, no coding required

## Quick Start

### Prerequisites

- Node.js >= 22
- An OpenClaw account (`npm install -g openclaw@latest`)
- API key from Anthropic (Claude) or OpenAI

### Installation

```bash
# Clone ShopClaw AI
git clone https://github.com/hohuyblon-stack/openclaw.git shopclaw
cd shopclaw

# Run the setup wizard
chmod +x scripts/setup.sh
./scripts/setup.sh
```

The setup wizard will guide you through:
1. Installing OpenClaw (if not already installed)
2. Connecting your messaging channels
3. Importing your product catalog
4. Customizing your AI's personality and policies

### Docker Deployment

```bash
cd docker
docker-compose up -d
```

## How It Works

```
Customer sends message on Zalo/Telegram/WhatsApp
        ↓
OpenClaw Gateway receives the message
        ↓
ShopClaw Skills process the intent:
  ├─ Product Catalog → Answer product questions
  ├─ Order Tracking  → Check order status
  ├─ FAQ & Policy    → Return/shipping/payment info
  ├─ Promotions      → Current deals and discounts
  └─ Escalation      → Hand off to human when needed
        ↓
AI responds in the customer's language
```

## Project Structure

```
shopclaw/
├── skills/                    # OpenClaw AI skills
│   ├── product-catalog/       # Product knowledge & recommendations
│   ├── customer-support/      # General customer service logic
│   ├── order-tracking/        # Order status & shipping updates
│   ├── faq-policy/            # Store policies & FAQs
│   └── promotions/            # Deals, discounts, campaigns
├── config/                    # Configuration templates
│   ├── openclaw.json          # Base OpenClaw config
│   ├── channels/              # Per-channel configs
│   └── templates/             # Industry-specific templates
├── workspace/                 # OpenClaw workspace files
│   ├── AGENTS.md              # Agent behavior & instructions
│   ├── SOUL.md                # Brand personality & tone
│   └── TOOLS.md               # Custom tool definitions
├── landing-page/              # Marketing website
├── scripts/                   # Setup & management scripts
├── data/                      # Sample product data
├── docker/                    # Docker deployment
└── docs/                      # Documentation
```

## Pricing Model (For Your Customers)

| Plan | Price/month | Messages | Channels | Products |
|------|-------------|----------|----------|----------|
| Starter | $29 / 690K VND | 1,000 | 2 | 100 |
| Growth | $79 / 1.89M VND | 5,000 | 4 | 500 |
| Pro | $199 / 4.79M VND | Unlimited | All | Unlimited |
| Enterprise | Custom | Unlimited | All + Custom | Unlimited |

## Documentation

- [Getting Started Guide](docs/getting-started.md)
- [Customization Guide](docs/customization.md)
- [Channel Setup](docs/channels.md)
- [Product Catalog Import](docs/product-catalog.md)
- [Pricing & Business Model](docs/pricing.md)

## Tech Stack

- **AI Engine:** [OpenClaw](https://github.com/openclaw/openclaw)
- **LLM:** Claude (Anthropic) or GPT-4 (OpenAI)
- **Messaging:** Zalo, Telegram, WhatsApp, Messenger, Discord
- **Deployment:** Docker, systemd, or manual
- **Language:** TypeScript / Node.js

## License

MIT License — Free to use, modify, and sell.

---

Built with [OpenClaw](https://openclaw.ai) 🦞
