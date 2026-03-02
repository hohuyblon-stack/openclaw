# ShopClaw AI — Custom Tools

## Available Data Tools

### product_search
Search the product catalog by keyword, category, or price range.
- Input: query (string), category (optional), min_price (optional), max_price (optional)
- Output: List of matching products with details

### product_details
Get full details for a specific product by SKU/ID.
- Input: product_id (string)
- Output: Complete product information including specs, stock, variants

### order_lookup
Look up an order by order number, phone, or email.
- Input: order_id (string) OR phone (string) OR email (string)
- Output: Order details including status, items, shipping info

### check_coupon
Validate a coupon code and return discount details.
- Input: code (string), cart_total (optional number)
- Output: Coupon validity, discount amount, terms

### active_promotions
List all currently active promotions and deals.
- Input: category (optional, filter by product category)
- Output: List of active promotions with codes and terms

### loyalty_balance
Check a customer's loyalty points balance.
- Input: customer_id (string) OR phone (string)
- Output: Points balance, tier, available rewards

## Tool Usage Guidelines

1. Always use the appropriate tool to look up real data — never guess
2. If a tool returns no results, inform the customer honestly
3. Combine tool results when helpful (e.g., product search + active promotions)
4. Cache tool results within the same conversation to avoid redundant lookups
