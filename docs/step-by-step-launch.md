# ShopClaw AI — Step-by-Step Launch Checklist

Complete checklist to go from zero to making money with ShopClaw AI.

## Phase 1: Setup (Day 1)

### 1.1 Get API Keys
- [ ] **Anthropic API Key** (for Claude AI)
  - Go to https://console.anthropic.com/
  - Sign up or log in
  - Go to "API Keys" → Create key
  - Copy the key (starts with `sk-ant-...`)
  - Save in `.env` file as `ANTHROPIC_API_KEY=sk-ant-...`

### 1.2 Create Telegram Bot (easiest channel to start)
- [ ] Open Telegram app
- [ ] Search for `@BotFather`
- [ ] Send `/newbot`
- [ ] Choose a name: `ShopClaw Demo` (or your shop name)
- [ ] Choose a username: `shopclaw_demo_bot` (must end with `bot`)
- [ ] Copy the bot token
- [ ] Save in `config/channels/telegram.json` → `credentials.bot_token`

### 1.3 Install & Run
- [ ] Install Node.js 22+ from https://nodejs.org
- [ ] Run: `npm install -g openclaw@latest`
- [ ] Run: `./scripts/setup.sh`
- [ ] Test: Send a message to your Telegram bot

## Phase 2: Customize (Day 2-3)

### 2.1 Add Your Products
- [ ] Edit `data/products.json` with your actual products
- [ ] Or use `./scripts/manage-products.sh add` to add interactively
- [ ] Run `./scripts/manage-products.sh validate` to check

### 2.2 Customize Policies
- [ ] Edit `skills/faq-policy/SKILL.md`
  - Update shipping methods and prices
  - Update return policy (window, conditions)
  - Update payment methods accepted
  - Update warranty terms

### 2.3 Customize AI Personality
- [ ] Edit `workspace/SOUL.md`
  - Set your brand voice (formal/casual/trendy)
  - Set Vietnamese tone (anh/chị or bạn)

### 2.4 Add Promotions
- [ ] Edit `data/promotions.json`
  - Add your current deals
  - Set valid discount codes

## Phase 3: Deploy Landing Page (Day 4)

### 3.1 Deploy to Vercel (free)
- [ ] Sign up at https://vercel.com (use GitHub login)
- [ ] Click "New Project" → Import from Git
- [ ] Select your `openclaw` repository
- [ ] Deploy settings auto-detected from `vercel.json`
- [ ] Click Deploy

### 3.2 Or Deploy to Netlify (free)
- [ ] Sign up at https://netlify.com (use GitHub login)
- [ ] Click "Add new site" → Import from Git
- [ ] Select your repository
- [ ] Deploy settings auto-detected from `netlify.toml`
- [ ] Click Deploy

### 3.3 Custom Domain (optional)
- [ ] Buy domain: shopclaw.vn or shopclaw.ai (Namecheap, GoDaddy, Tenten)
- [ ] Add custom domain in Vercel/Netlify settings
- [ ] Update DNS records as instructed

## Phase 4: Payments (Day 5)

### 4.1 Stripe Setup
- [ ] Sign up at https://stripe.com
- [ ] Complete identity verification
- [ ] Get API keys from Dashboard → Developers → API Keys
- [ ] Add to `.env`: `STRIPE_SECRET_KEY=sk_test_...`
- [ ] Update `landing-page/dashboard/pricing.html` with your publishable key
- [ ] Run: `node scripts/stripe-setup.js` to create products
- [ ] Set up webhook for subscription events

### 4.2 For Vietnamese Market (additional)
- [ ] Set up MoMo Business: https://business.momo.vn
- [ ] Set up VNPay: https://vnpay.vn
- [ ] Add bank transfer info to your policies

## Phase 5: Beta Test (Day 6-14)

### 5.1 Find Beta Users
- [ ] Post on Facebook groups for shop owners
  - Hội Kinh Doanh Online
  - Shopee Seller Vietnam
  - TikTok Shop Seller Community
- [ ] Offer: "FREE 1 month — Looking for 20 shops to test our new AI customer service"
- [ ] Direct message 50 shop owners on Shopee/Lazada

### 5.2 Collect Feedback
- [ ] Create Google Form for feedback
- [ ] Questions:
  - How many messages does AI handle correctly? (out of 10)
  - What questions does AI answer wrong?
  - What features are missing?
  - Would you pay for this? How much?
- [ ] Iterate based on feedback daily

### 5.3 Get Testimonials
- [ ] Ask satisfied beta users for a quote + permission to use it
- [ ] Screenshot positive feedback from chat
- [ ] Record short video testimonials

## Phase 6: Launch (Day 15)

### 6.1 Prepare
- [ ] Fix all issues from beta feedback
- [ ] Update landing page with real testimonials
- [ ] Prepare ad creatives (see `marketing/ad-copy.md`)
- [ ] Set up email marketing (Mailchimp/ConvertKit free tier)
- [ ] Import email templates from `email-templates/`

### 6.2 Launch Campaign
- [ ] Post on social media (see `marketing/social-media-calendar.md`)
- [ ] Start Facebook Ads (budget: 200K-500Kđ/day)
- [ ] Start Zalo Ads (budget: 200K-500Kđ/day)
- [ ] Email blast to beta users list
- [ ] Post on ProductHunt (for international audience)

### 6.3 Monitor
- [ ] Check AI resolution rate daily (target: >80%)
- [ ] Monitor customer conversations in Dashboard
- [ ] Respond to escalated conversations within 15 minutes
- [ ] Track signups and conversion rate

## Phase 7: Scale (Month 2+)

### 7.1 Add More Channels
- [ ] Zalo OA: https://oa.zalo.me
- [ ] Facebook Messenger: https://developers.facebook.com
- [ ] WhatsApp Business: https://business.facebook.com
- [ ] Discord: https://discord.com/developers

### 7.2 Growth Tactics
- [ ] Referral program: 20% commission or 1 month free
- [ ] Content marketing: Blog posts, YouTube tutorials
- [ ] SEO: Optimize landing page for "AI chatbot shop online"
- [ ] Partnerships: Approach Shopee/Lazada seller communities
- [ ] Case studies: Publish detailed results from top customers

### 7.3 Product Expansion
- [ ] Add more industry templates (Beauty, Health, Home...)
- [ ] Build Shopee/Lazada API integration for auto-sync products
- [ ] Build analytics dashboard with real data
- [ ] Offer white-label for agencies

---

## Quick Reference: Key URLs

| Service | URL | Purpose |
|---------|-----|---------|
| Anthropic | console.anthropic.com | AI API key |
| Stripe | dashboard.stripe.com | Payments |
| Vercel | vercel.com | Landing page hosting |
| Netlify | netlify.com | Alternative hosting |
| Telegram BotFather | t.me/BotFather | Create Telegram bot |
| Zalo Developer | developers.zalo.me | Zalo OA setup |
| Meta Developer | developers.facebook.com | Messenger/WhatsApp |
| Namecheap | namecheap.com | Domain registration |
| Mailchimp | mailchimp.com | Email marketing |
