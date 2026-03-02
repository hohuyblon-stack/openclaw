# Customization Guide

ShopClaw AI is fully customizable. This guide shows you how to tailor the AI to match your brand, products, and policies.

## 1. Brand Personality (SOUL.md)

Edit `workspace/SOUL.md` to define your AI's personality:

```markdown
## My Personality
- Warm and friendly (for a family-oriented brand)
- Trendy and cool (for a fashion brand)
- Expert and authoritative (for a tech brand)
```

### Vietnamese Tone Examples

**Formal (luxury brand):**
> "Kính chào quý khách! Rất hân hạnh được hỗ trợ quý khách ạ."

**Casual (youth brand):**
> "Hello bạn! Bên mình có thể giúp gì nè?"

**Warm (family brand):**
> "Dạ chào anh/chị! Em rất vui được hỗ trợ ạ."

## 2. Product Catalog

### Format
Edit `data/products.json`. Each product should have:

```json
{
  "id": "SKU-001",
  "name": "Product Name (English)",
  "name_vi": "Tên sản phẩm (Tiếng Việt)",
  "category": "Category",
  "price": 29.99,
  "price_vnd": 719000,
  "description": "English description",
  "description_vi": "Mô tả tiếng Việt",
  "stock": 100,
  "variants": [
    { "name": "Size M - Black", "stock": 30 }
  ],
  "tags": ["keyword1", "keyword2"]
}
```

### Tips
- Include both VN and EN names/descriptions for bilingual support
- Keep descriptions concise but informative
- Update stock numbers regularly
- Use meaningful tags for better search

## 3. Store Policies

Edit `skills/faq-policy/SKILL.md` to match your actual policies:

- Shipping methods and prices
- Return window (7 days? 30 days?)
- Accepted payment methods
- Warranty terms
- Business hours

## 4. Promotions

Edit `data/promotions.json` to add your active deals:

```json
{
  "id": "PROMO-001",
  "name": "Summer Sale",
  "type": "percentage",
  "discount": 15,
  "code": "SUMMER15",
  "min_order": 200000,
  "start_date": "2026-06-01",
  "end_date": "2026-06-30",
  "active": true
}
```

## 5. Industry Templates

Choose a pre-built template from `config/templates/`:

| Template | Best for |
|----------|----------|
| `fashion-store.json` | Clothing, shoes, accessories |
| `electronics-store.json` | Phones, laptops, gadgets |
| `food-store.json` | Food, beverages, groceries |

## 6. Escalation Settings

Configure when and how the AI hands off to human support:

In `config/openclaw.json`:
```json
"escalation": {
  "enabled": true,
  "notify_channel": "telegram",
  "response_time_minutes": 15
}
```

## 7. Adding Custom Skills

Create a new skill by adding a directory under `skills/`:

```
skills/
  └── my-custom-skill/
      └── SKILL.md
```

In `SKILL.md`, define:
- What the skill does
- When it should be activated
- Example interactions
- Data sources

Then add it to the enabled skills list in `config/openclaw.json`.
