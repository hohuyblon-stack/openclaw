#!/usr/bin/env bash
# ShopClaw AI — Product Catalog Manager
# Easily add, update, or import products into ShopClaw AI's catalog.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
PRODUCTS_FILE="$PROJECT_DIR/data/products.json"

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

success() { echo -e "${GREEN}[✓]${NC} $1"; }
info()    { echo -e "${CYAN}[INFO]${NC} $1"; }
error()   { echo -e "${RED}[✗]${NC} $1"; }

show_help() {
    echo -e "${BOLD}ShopClaw AI — Product Catalog Manager${NC}"
    echo ""
    echo "Usage: $0 <command> [options]"
    echo ""
    echo "Commands:"
    echo "  add          Add a new product interactively"
    echo "  list         List all products"
    echo "  count        Show product count"
    echo "  import-csv   Import products from CSV file"
    echo "  export-csv   Export products to CSV file"
    echo "  validate     Validate the products.json file"
    echo ""
    echo "Examples:"
    echo "  $0 add"
    echo "  $0 list"
    echo "  $0 import-csv products.csv"
    echo "  $0 export-csv output.csv"
}

cmd_list() {
    if ! command -v python3 &> /dev/null; then
        error "python3 is required for this command"
        exit 1
    fi

    python3 -c "
import json
with open('$PRODUCTS_FILE') as f:
    data = json.load(f)

products = data.get('products', [])
print(f'\n  Total products: {len(products)}\n')
print(f'  {\"ID\":<12} {\"Name\":<35} {\"Price\":>10} {\"Stock\":>6}')
print(f'  {\"-\"*12} {\"-\"*35} {\"-\"*10} {\"-\"*6}')
for p in products:
    price = f\"{p.get('price_vnd', 0):,}đ\" if p.get('price_vnd') else f\"\${p.get('price', 0)}\"
    print(f'  {p[\"id\"]:<12} {p[\"name\"][:35]:<35} {price:>10} {p.get(\"stock\", 0):>6}')
print()
"
}

cmd_count() {
    if ! command -v python3 &> /dev/null; then
        error "python3 is required for this command"
        exit 1
    fi

    python3 -c "
import json
with open('$PRODUCTS_FILE') as f:
    data = json.load(f)
count = len(data.get('products', []))
print(f'Product count: {count}')
"
}

cmd_validate() {
    if ! command -v python3 &> /dev/null; then
        error "python3 is required for this command"
        exit 1
    fi

    python3 -c "
import json, sys
try:
    with open('$PRODUCTS_FILE') as f:
        data = json.load(f)
    products = data.get('products', [])
    errors = []
    for i, p in enumerate(products):
        if 'id' not in p: errors.append(f'Product {i}: missing id')
        if 'name' not in p: errors.append(f'Product {i}: missing name')
        if 'price' not in p and 'price_vnd' not in p: errors.append(f'Product {i}: missing price')
        if 'stock' not in p: errors.append(f'Product {i}: missing stock')
    if errors:
        print('Validation errors:')
        for e in errors: print(f'  - {e}')
        sys.exit(1)
    else:
        print(f'✓ All {len(products)} products are valid!')
except json.JSONDecodeError as e:
    print(f'Invalid JSON: {e}')
    sys.exit(1)
"
    success "Products catalog is valid"
}

cmd_add() {
    echo -e "\n${BOLD}Add New Product${NC}\n"

    read -p "Product ID (e.g., SKU-006): " PROD_ID
    read -p "Product name (EN): " PROD_NAME
    read -p "Product name (VI): " PROD_NAME_VI
    read -p "Category: " PROD_CATEGORY
    read -p "Price (USD): " PROD_PRICE
    read -p "Price (VND): " PROD_PRICE_VND
    read -p "Stock quantity: " PROD_STOCK
    read -p "Description (EN): " PROD_DESC
    read -p "Description (VI): " PROD_DESC_VI

    if ! command -v python3 &> /dev/null; then
        error "python3 is required for this command"
        exit 1
    fi

    python3 -c "
import json
with open('$PRODUCTS_FILE') as f:
    data = json.load(f)

new_product = {
    'id': '$PROD_ID',
    'name': '$PROD_NAME',
    'name_vi': '$PROD_NAME_VI',
    'category': '$PROD_CATEGORY',
    'price': float('${PROD_PRICE:-0}'),
    'currency': 'USD',
    'price_vnd': int('${PROD_PRICE_VND:-0}'),
    'description': '$PROD_DESC',
    'description_vi': '$PROD_DESC_VI',
    'specs': {},
    'stock': int('${PROD_STOCK:-0}'),
    'variants': [],
    'tags': [],
    'rating': 0,
    'reviews_count': 0
}

data['products'].append(new_product)

with open('$PRODUCTS_FILE', 'w') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print(f'Product {new_product[\"id\"]} added successfully!')
"
    success "Product $PROD_ID added to catalog"
}

# Main
case "${1:-help}" in
    add)        cmd_add ;;
    list)       cmd_list ;;
    count)      cmd_count ;;
    validate)   cmd_validate ;;
    help|--help|-h) show_help ;;
    *)          error "Unknown command: $1"; show_help; exit 1 ;;
esac
