# Pricing & Business Model Guide

This guide helps you set up pricing for your ShopClaw AI business.

## Recommended Pricing Tiers

### Vietnamese Market (VND)

| Plan | Price/Month | Messages | Channels | Products | Target |
|------|-------------|----------|----------|----------|--------|
| **Starter** | 690,000đ | 1,000 | 2 | 100 | Solo sellers on Shopee/Lazada |
| **Growth** | 1,890,000đ | 5,000 | 4 | 500 | Growing shops with multiple channels |
| **Pro** | 4,790,000đ | Unlimited | All | Unlimited | Established brands |
| **Enterprise** | Custom | Unlimited | All + Custom | Unlimited | Large retailers |

### International Market (USD)

| Plan | Price/Month | Messages | Channels | Products | Target |
|------|-------------|----------|----------|----------|--------|
| **Starter** | $29 | 1,000 | 2 | 100 | Small Etsy/Shopify sellers |
| **Growth** | $79 | 5,000 | 4 | 500 | Growing e-commerce businesses |
| **Pro** | $199 | Unlimited | All | Unlimited | Established brands |
| **Enterprise** | Custom | Unlimited | All + Custom | Unlimited | Large retailers |

## Cost Structure

### Your Costs (per customer)

| Cost Item | Estimated Monthly |
|-----------|-------------------|
| LLM API (Claude/GPT-4) | $5-50 depending on usage |
| Server hosting (VPS) | $5-20 |
| OpenClaw | Free (open source) |
| **Total per customer** | **$10-70** |

### Profit Margins

| Plan | Revenue | Est. Cost | Profit | Margin |
|------|---------|-----------|--------|--------|
| Starter | $29 | ~$10 | ~$19 | 65% |
| Growth | $79 | ~$25 | ~$54 | 68% |
| Pro | $199 | ~$50 | ~$149 | 75% |

## Cost Optimization Tips

1. **Use Claude Sonnet** instead of Opus for most queries (3-5x cheaper)
2. **Cache common responses** — Same product questions get cached answers
3. **Set message limits** — Prevent abuse with monthly quotas per plan
4. **Use model fallback** — Primary: Claude Sonnet, Fallback: GPT-4o-mini for simple queries

## Payment Integration

### For Vietnamese Market
- **MoMo Business** — Most popular e-wallet
- **VNPay** — Bank transfer integration
- **Stripe** — International cards

### For International Market
- **Stripe** — Cards, Apple Pay, Google Pay
- **PayPal** — Popular internationally
- **Paddle** — Handles tax/compliance automatically

## Go-to-Market Strategy

### Phase 1: Beta (Month 1-2)
- Offer free accounts to 10-20 shop owners
- Collect feedback and testimonials
- Iterate on skills and responses

### Phase 2: Launch (Month 3)
- Launch landing page with 3 pricing tiers
- Target Shopee/Lazada sellers in Vietnam
- Run Facebook/Zalo ads targeting shop owners
- Offer 14-day free trial

### Phase 3: Growth (Month 4-6)
- Add more industry templates
- Launch referral program (20% commission)
- Expand to international markets (Etsy, Shopify sellers)
- Develop self-service onboarding dashboard

### Phase 4: Scale (Month 7-12)
- Build integrations with Shopee, Lazada, TikTok Shop APIs
- Add analytics dashboard
- Offer white-label solution
- Explore Enterprise deals

## Key Metrics to Track

- **MRR** (Monthly Recurring Revenue)
- **Churn Rate** — Keep under 5%
- **Customer Acquisition Cost (CAC)**
- **Lifetime Value (LTV)** — Target LTV:CAC ratio of 3:1+
- **Messages Handled** — Efficiency metric
- **Customer Satisfaction** — Survey end-users monthly
