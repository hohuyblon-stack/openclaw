#!/usr/bin/env node
/**
 * ShopClaw AI — Stripe Subscription Setup
 *
 * This script creates the Stripe products and pricing plans
 * for your ShopClaw AI subscription business.
 *
 * Usage:
 *   1. Set STRIPE_SECRET_KEY in .env
 *   2. Run: node scripts/stripe-setup.js
 *
 * This will create:
 *   - 3 products (Starter, Growth, Pro)
 *   - 6 prices (VND + USD for each plan)
 *   - A customer portal configuration
 */

const PLANS = [
    {
        name: 'ShopClaw AI — Starter',
        description: '1,000 messages/month, 2 channels, 100 products',
        prices: [
            { currency: 'usd', amount: 2900, interval: 'month' },        // $29/mo
            { currency: 'vnd', amount: 690000, interval: 'month' },       // 690,000đ/mo
        ],
        metadata: {
            plan_id: 'starter',
            messages_limit: '1000',
            channels_limit: '2',
            products_limit: '100',
        }
    },
    {
        name: 'ShopClaw AI — Growth',
        description: '5,000 messages/month, 4 channels, 500 products, analytics',
        prices: [
            { currency: 'usd', amount: 7900, interval: 'month' },        // $79/mo
            { currency: 'vnd', amount: 1890000, interval: 'month' },      // 1,890,000đ/mo
        ],
        metadata: {
            plan_id: 'growth',
            messages_limit: '5000',
            channels_limit: '4',
            products_limit: '500',
        }
    },
    {
        name: 'ShopClaw AI — Pro',
        description: 'Unlimited messages, all channels, unlimited products, API access, white-label',
        prices: [
            { currency: 'usd', amount: 19900, interval: 'month' },       // $199/mo
            { currency: 'vnd', amount: 4790000, interval: 'month' },      // 4,790,000đ/mo
        ],
        metadata: {
            plan_id: 'pro',
            messages_limit: 'unlimited',
            channels_limit: 'unlimited',
            products_limit: 'unlimited',
        }
    }
];

async function main() {
    // Check for Stripe key
    const secretKey = process.env.STRIPE_SECRET_KEY;
    if (!secretKey) {
        console.error('\n❌ STRIPE_SECRET_KEY not found in environment.\n');
        console.log('To set up Stripe:');
        console.log('  1. Sign up at https://stripe.com');
        console.log('  2. Get your secret key from https://dashboard.stripe.com/apikeys');
        console.log('  3. Add to .env: STRIPE_SECRET_KEY=sk_test_...');
        console.log('  4. Run this script again: node scripts/stripe-setup.js\n');

        // Show what would be created
        console.log('This script will create the following Stripe products:\n');
        PLANS.forEach((plan, i) => {
            console.log(`${i + 1}. ${plan.name}`);
            console.log(`   ${plan.description}`);
            plan.prices.forEach(p => {
                const amount = p.currency === 'usd'
                    ? `$${(p.amount / 100).toFixed(0)}`
                    : `${p.amount.toLocaleString()}đ`;
                console.log(`   → ${amount}/${p.interval} (${p.currency.toUpperCase()})`);
            });
            console.log('');
        });
        return;
    }

    let stripe;
    try {
        stripe = require('stripe')(secretKey);
    } catch {
        console.error('❌ Stripe package not found. Install it:');
        console.error('   npm install stripe');
        return;
    }

    console.log('\n🦞 ShopClaw AI — Stripe Setup\n');
    console.log('Creating products and prices...\n');

    const results = [];

    for (const plan of PLANS) {
        // Create product
        const product = await stripe.products.create({
            name: plan.name,
            description: plan.description,
            metadata: plan.metadata,
        });
        console.log(`✓ Product created: ${product.name} (${product.id})`);

        // Create prices
        const priceIds = {};
        for (const priceConfig of plan.prices) {
            const price = await stripe.prices.create({
                product: product.id,
                unit_amount: priceConfig.amount,
                currency: priceConfig.currency,
                recurring: { interval: priceConfig.interval },
                metadata: { plan_id: plan.metadata.plan_id },
            });
            priceIds[priceConfig.currency] = price.id;
            const displayAmount = priceConfig.currency === 'usd'
                ? `$${(priceConfig.amount / 100).toFixed(0)}`
                : `${priceConfig.amount.toLocaleString()}đ`;
            console.log(`  ✓ Price: ${displayAmount}/${priceConfig.interval} (${price.id})`);
        }

        results.push({
            plan: plan.metadata.plan_id,
            product_id: product.id,
            prices: priceIds,
        });
    }

    // Output summary
    console.log('\n✅ Setup complete! Here are your Stripe IDs:\n');
    console.log(JSON.stringify(results, null, 2));
    console.log('\nAdd these to your config/openclaw.json under "stripe" key.');
    console.log('\nNext steps:');
    console.log('  1. Set up webhook endpoint at https://dashboard.stripe.com/webhooks');
    console.log('  2. Point webhook to: https://your-domain.com/api/stripe/webhook');
    console.log('  3. Listen for: customer.subscription.created, invoice.paid, invoice.payment_failed');
}

main().catch(console.error);
