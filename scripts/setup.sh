#!/usr/bin/env bash
# ShopClaw AI — Setup Wizard
# This script sets up ShopClaw AI with OpenClaw for your e-commerce store.

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Helpers
info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[✓]${NC} $1"; }
warn()    { echo -e "${YELLOW}[!]${NC} $1"; }
error()   { echo -e "${RED}[✗]${NC} $1"; }
header()  { echo -e "\n${CYAN}${BOLD}$1${NC}\n"; }

# Banner
echo -e "${RED}"
cat << 'EOF'
   _____ __                 ________
  / ___// /_  ____  ____   / ____/ /___ _      __
  \__ \/ __ \/ __ \/ __ \ / /   / / __ \ | /| / /
 ___/ / / / / /_/ / /_/ // /___/ / /_/ / |/ |/ /
/____/_/ /_/\____/ .___/ \____/_/\__,_/|__/|__/
                /_/              AI Customer Service
EOF
echo -e "${NC}"
echo -e "${BOLD}Welcome to ShopClaw AI Setup Wizard${NC}"
echo "AI Customer Service for E-commerce — Powered by OpenClaw"
echo ""

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
fi
info "Detected OS: $OS"

# ==================== Step 1: Check Prerequisites ====================
header "Step 1/5: Checking Prerequisites"

# Check Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v | sed 's/v//')
    NODE_MAJOR=$(echo "$NODE_VERSION" | cut -d. -f1)
    if [ "$NODE_MAJOR" -ge 22 ]; then
        success "Node.js $NODE_VERSION found"
    else
        error "Node.js 22+ required (found $NODE_VERSION)"
        echo "  Install: https://nodejs.org/"
        exit 1
    fi
else
    error "Node.js not found. Please install Node.js 22+"
    echo "  Install: https://nodejs.org/"
    exit 1
fi

# Check OpenClaw
if command -v openclaw &> /dev/null; then
    OPENCLAW_VERSION=$(openclaw --version 2>/dev/null || echo "unknown")
    success "OpenClaw found: $OPENCLAW_VERSION"
else
    warn "OpenClaw not found. Installing..."
    npm install -g openclaw@latest
    success "OpenClaw installed"
fi

# ==================== Step 2: Store Configuration ====================
header "Step 2/5: Store Configuration"

echo -e "Let's set up your store information.\n"

read -p "Store name (e.g., MyShop): " STORE_NAME
STORE_NAME=${STORE_NAME:-"MyShop"}

read -p "Default language [vi/en] (default: vi): " DEFAULT_LANG
DEFAULT_LANG=${DEFAULT_LANG:-"vi"}

read -p "Timezone (default: Asia/Ho_Chi_Minh): " TIMEZONE
TIMEZONE=${TIMEZONE:-"Asia/Ho_Chi_Minh"}

read -p "Business hours start (default: 08:00): " BIZ_START
BIZ_START=${BIZ_START:-"08:00"}

read -p "Business hours end (default: 22:00): " BIZ_END
BIZ_END=${BIZ_END:-"22:00"}

success "Store configured: $STORE_NAME"

# ==================== Step 3: LLM Provider ====================
header "Step 3/5: AI Model Configuration"

echo "Which AI provider do you want to use?"
echo "  1) Anthropic Claude (Recommended)"
echo "  2) OpenAI GPT-4"
echo ""
read -p "Choose [1/2] (default: 1): " AI_CHOICE
AI_CHOICE=${AI_CHOICE:-"1"}

if [ "$AI_CHOICE" = "1" ]; then
    AI_PROVIDER="anthropic"
    AI_MODEL="claude-sonnet-4-6"
    read -p "Anthropic API Key: " API_KEY
else
    AI_PROVIDER="openai"
    AI_MODEL="gpt-4o"
    read -p "OpenAI API Key: " API_KEY
fi

if [ -z "$API_KEY" ]; then
    warn "No API key provided. You'll need to add it manually to the config."
else
    success "API key configured for $AI_PROVIDER"
fi

# ==================== Step 4: Channel Setup ====================
header "Step 4/5: Messaging Channels"

echo "Which channels do you want to enable?"
echo ""

CHANNELS=()

read -p "Enable Zalo? [y/N]: " ENABLE_ZALO
if [[ "$ENABLE_ZALO" =~ ^[Yy] ]]; then
    CHANNELS+=("zalo")
    success "Zalo enabled — Configure credentials in config/channels/zalo.json"
fi

read -p "Enable Telegram? [y/N]: " ENABLE_TELEGRAM
if [[ "$ENABLE_TELEGRAM" =~ ^[Yy] ]]; then
    read -p "  Telegram Bot Token (from @BotFather): " TG_TOKEN
    CHANNELS+=("telegram")
    success "Telegram enabled"
fi

read -p "Enable WhatsApp? [y/N]: " ENABLE_WHATSAPP
if [[ "$ENABLE_WHATSAPP" =~ ^[Yy] ]]; then
    CHANNELS+=("whatsapp")
    success "WhatsApp enabled — Configure credentials in config/channels/whatsapp.json"
fi

read -p "Enable Messenger? [y/N]: " ENABLE_MESSENGER
if [[ "$ENABLE_MESSENGER" =~ ^[Yy] ]]; then
    CHANNELS+=("messenger")
    success "Messenger enabled — Configure credentials in config/channels/messenger.json"
fi

read -p "Enable Discord? [y/N]: " ENABLE_DISCORD
if [[ "$ENABLE_DISCORD" =~ ^[Yy] ]]; then
    CHANNELS+=("discord")
    success "Discord enabled — Configure credentials in config/channels/discord.json"
fi

if [ ${#CHANNELS[@]} -eq 0 ]; then
    warn "No channels enabled. You can enable them later in config/channels/"
fi

# ==================== Step 5: Store Template ====================
header "Step 5/5: Store Template"

echo "Choose a store template:"
echo "  1) Fashion / Thời trang"
echo "  2) Electronics / Điện tử"
echo "  3) Food & Grocery / Thực phẩm"
echo "  4) General (no template)"
echo ""
read -p "Choose [1-4] (default: 4): " TEMPLATE_CHOICE
TEMPLATE_CHOICE=${TEMPLATE_CHOICE:-"4"}

case $TEMPLATE_CHOICE in
    1) TEMPLATE="fashion-store"; success "Fashion template selected" ;;
    2) TEMPLATE="electronics-store"; success "Electronics template selected" ;;
    3) TEMPLATE="food-store"; success "Food template selected" ;;
    *) TEMPLATE="none"; info "No template selected — using general config" ;;
esac

# ==================== Generate Config ====================
header "Generating Configuration..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Create workspace directory
WORKSPACE_DIR="$HOME/.openclaw/workspace"
mkdir -p "$WORKSPACE_DIR/skills"

# Copy skills
info "Installing ShopClaw skills..."
for skill_dir in "$PROJECT_DIR/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    mkdir -p "$WORKSPACE_DIR/skills/$skill_name"
    cp "$skill_dir"SKILL.md "$WORKSPACE_DIR/skills/$skill_name/"
    success "  Installed skill: $skill_name"
done

# Copy workspace files
info "Setting up workspace..."
cp "$PROJECT_DIR/workspace/AGENTS.md" "$WORKSPACE_DIR/"
cp "$PROJECT_DIR/workspace/SOUL.md" "$WORKSPACE_DIR/"
cp "$PROJECT_DIR/workspace/TOOLS.md" "$WORKSPACE_DIR/"

# Update SOUL.md with store name
sed -i "s/this store/$STORE_NAME/g" "$WORKSPACE_DIR/SOUL.md" 2>/dev/null || true
sed -i "s/\[Shop Name\]/$STORE_NAME/g" "$WORKSPACE_DIR/AGENTS.md" 2>/dev/null || true

# Copy data files
mkdir -p "$WORKSPACE_DIR/data"
cp "$PROJECT_DIR/data/"*.json "$WORKSPACE_DIR/data/"

success "Workspace configured at $WORKSPACE_DIR"

# ==================== Summary ====================
header "Setup Complete!"

echo -e "${GREEN}${BOLD}ShopClaw AI is ready!${NC}\n"
echo "  Store:     $STORE_NAME"
echo "  AI:        $AI_PROVIDER ($AI_MODEL)"
echo "  Language:  $DEFAULT_LANG"
echo "  Channels:  ${CHANNELS[*]:-'none (configure later)'}"
echo "  Template:  $TEMPLATE"
echo "  Workspace: $WORKSPACE_DIR"
echo ""
echo -e "${BOLD}Next Steps:${NC}"
echo "  1. Add your products to data/products.json"
echo "  2. Configure channel credentials in config/channels/"
echo "  3. Customize SOUL.md for your brand voice"
echo "  4. Start OpenClaw:"
echo ""
echo -e "     ${CYAN}openclaw start${NC}"
echo ""
echo "  5. Send a test message on your configured channel!"
echo ""
echo -e "${BOLD}Useful commands:${NC}"
echo "  openclaw doctor    — Check configuration"
echo "  openclaw status    — View running status"
echo "  openclaw logs      — View conversation logs"
echo ""
echo -e "Need help? Visit: ${CYAN}https://docs.shopclaw.ai${NC}"
echo ""
success "Happy selling! 🦞"
