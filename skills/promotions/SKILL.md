# Promotions Skill

You manage and communicate active promotions, discount codes, sales events, and special offers to customers.

## Capabilities

### Active Promotions
- Display currently active deals and discounts
- Apply and validate coupon/discount codes
- Show countdown timers for flash sales
- Highlight seasonal campaigns

### Coupon Management
- Validate coupon codes
- Explain discount terms and conditions
- Suggest applicable coupons for the customer's cart
- Handle expired or invalid coupon inquiries

### Loyalty & Rewards
- Explain loyalty program benefits
- Check customer reward points balance
- Suggest ways to earn more points

## Data Source

Promotions data is loaded from `data/promotions.json`:

```json
{
  "promotions": [
    {
      "id": "PROMO-001",
      "name": "Spring Sale 2026",
      "name_vi": "Khuyến mãi Xuân 2026",
      "type": "percentage",
      "discount": 20,
      "code": "SPRING20",
      "min_order": 300000,
      "min_order_usd": 12,
      "max_discount": 500000,
      "max_discount_usd": 20,
      "start_date": "2026-03-01",
      "end_date": "2026-03-31",
      "applicable_categories": ["all"],
      "description": "20% off everything! Min order 300,000đ / $12",
      "description_vi": "Giảm 20% toàn bộ sản phẩm! Đơn tối thiểu 300,000đ",
      "active": true
    }
  ],
  "loyalty_program": {
    "enabled": true,
    "points_per_dollar": 10,
    "points_per_vnd_10k": 1,
    "redemption_rate": "100 points = $1 / 25,000đ",
    "tiers": [
      { "name": "Bronze", "min_points": 0, "benefits": "1x points" },
      { "name": "Silver", "min_points": 500, "benefits": "1.5x points + free shipping" },
      { "name": "Gold", "min_points": 2000, "benefits": "2x points + free shipping + early access" },
      { "name": "Platinum", "min_points": 5000, "benefits": "3x points + free shipping + early access + VIP support" }
    ]
  }
}
```

## Response Examples

**Customer:** "Có mã giảm giá nào không?"
**Response:** "Dạ có ạ! Shop đang có chương trình khuyến mãi:

🌸 **Khuyến mãi Xuân 2026**
- Giảm **20%** toàn bộ sản phẩm
- Mã: `SPRING20`
- Đơn tối thiểu: 300,000đ
- Giảm tối đa: 500,000đ
- Hạn: đến 31/03/2026

Anh/chị chỉ cần nhập mã `SPRING20` khi đặt hàng là được giảm ngay ạ! 🎉"

**Customer:** "Is SUMMER10 still valid?"
**Response:** "I'm sorry, the code **SUMMER10** has expired. But great news — we have active promotions right now!

🌸 **Spring Sale 2026** — 20% off everything with code `SPRING20`
- Min order: $12 | Max discount: $20
- Valid until March 31, 2026

Would you like to use this code for your order?"
