// ShopClaw AI — Landing Page JavaScript

document.addEventListener('DOMContentLoaded', () => {
    initLanguageToggle();
    initCurrencyToggle();
    initDemoChat();
    initCTAForm();
    initMobileMenu();
    initSmoothScroll();
});

// ==================== Language Toggle ====================
function initLanguageToggle() {
    const langBtns = document.querySelectorAll('.lang-btn');
    const savedLang = localStorage.getItem('shopclaw-lang') || 'vi';

    setLanguage(savedLang);

    langBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const lang = btn.dataset.lang;
            setLanguage(lang);
            localStorage.setItem('shopclaw-lang', lang);
        });
    });
}

function setLanguage(lang) {
    document.querySelectorAll('.lang-btn').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.lang === lang);
    });

    document.querySelectorAll('[data-vi]').forEach(el => {
        const text = el.getAttribute(`data-${lang}`);
        if (text) el.innerHTML = text;
    });

    document.querySelectorAll('[data-vi-placeholder]').forEach(el => {
        const placeholder = el.getAttribute(`data-${lang}-placeholder`);
        if (placeholder) el.placeholder = placeholder;
    });

    document.documentElement.lang = lang;
}

// ==================== Currency Toggle ====================
function initCurrencyToggle() {
    const toggle = document.getElementById('currencyToggle');
    if (!toggle) return;

    toggle.addEventListener('change', () => {
        const showUSD = toggle.checked;
        document.querySelectorAll('.price-vnd').forEach(el => {
            el.style.display = showUSD ? 'none' : 'inline';
        });
        document.querySelectorAll('.price-usd').forEach(el => {
            el.style.display = showUSD ? 'inline' : 'none';
        });
    });
}

// ==================== Demo Chat ====================
const demoResponses = {
    vi: {
        'áo thun': `Dạ có ạ! Shop đang có **Áo Thun Cotton Cao Cấp** 🎽

• Giá: 249,000đ (đang giảm 20% với mã SPRING20)
• Chất liệu: 100% cotton organic, 180gsm
• Size: S, M, L, XL
• Màu: Trắng, Đen
• Còn hàng: 150 cái

Mã SPRING20 giảm thêm 20%! Anh/chị muốn đặt size nào ạ?`,

        'đơn hàng': `Dạ, em kiểm tra đơn **ORD-20260228-001** cho anh/chị:

📦 Trạng thái: **Đang vận chuyển**
🚚 Đơn vị: GHN | Mã vận đơn: GHN987654321
📅 Dự kiến giao: 03/03/2026

**Chi tiết:**
- Áo Thun Cotton Cao Cấp (Trắng M) x2
- Bộ Phin Cà Phê Việt Nam x1
- Tổng: 709,600đ (đã giảm 20%)

Anh/chị cần hỗ trợ gì thêm không ạ?`,

        'giảm giá': `Dạ, shop đang có 3 chương trình khuyến mãi:

🌸 **Xuân 2026** — Giảm 20% toàn bộ
   Mã: SPRING20 | Đơn tối thiểu 300,000đ

🚚 **Miễn Phí Ship Cuối Tuần**
   Mã: FREESHIP | Đơn trên 200,000đ | 7-9/03

🎉 **Khách Hàng Mới** — Giảm 50,000đ
   Mã: WELCOME | Đơn đầu tiên từ 150,000đ

Anh/chị muốn mua sản phẩm nào ạ?`,

        'đổi trả': `Dạ, chính sách đổi trả của shop:

✅ **Đổi/trả trong 30 ngày** từ ngày nhận hàng
✅ Miễn phí ship đổi trả nếu lỗi từ shop
✅ Hoàn tiền trong 3-5 ngày làm việc

❌ Không áp dụng: hàng đã sử dụng, hàng sale cuối, hàng cá nhân hóa

**Quy trình:** Liên hệ shop → Gửi ảnh/mô tả → Duyệt trong 24h → Gửi hàng trả → Nhận hoàn tiền

Anh/chị cần đổi trả sản phẩm nào ạ?`,

        default: `Dạ, em có thể hỗ trợ anh/chị:
• 🛍️ Tìm sản phẩm, tư vấn mua hàng
• 📦 Kiểm tra đơn hàng, theo dõi giao hàng
• 🏷️ Mã giảm giá, khuyến mãi
• 📋 Chính sách đổi trả, bảo hành

Anh/chị cần hỗ trợ gì ạ?`
    },
    en: {
        't-shirt': `Yes, we have the **Premium Cotton T-Shirt**! 🎽

• Price: $9.99 (20% off with code SPRING20!)
• Material: 100% organic cotton, 180gsm
• Sizes: S, M, L, XL
• Colors: White, Black
• In stock: 150 units

Use code SPRING20 for 20% off! Which size would you like?`,

        'order': `Here's the status of order **ORD-20260228-001**:

📦 Status: **In Transit**
🚚 Carrier: GHN | Tracking: GHN987654321
📅 ETA: March 3, 2026

**Items:**
- Premium Cotton T-Shirt (White M) x2
- Vietnamese Coffee Drip Set x1
- Total: $28.38 (20% off applied)

Need anything else?`,

        'discount': `We have 3 active promotions:

🌸 **Spring Sale 2026** — 20% off everything
   Code: SPRING20 | Min order: $12

🚚 **Free Shipping Weekend**
   Code: FREESHIP | Orders over $8 | Mar 7-9

🎉 **New Customer** — $2 off first order
   Code: WELCOME | Min order: $6

What would you like to order?`,

        'return': `Our return policy:

✅ **30-day returns** from delivery date
✅ Free return shipping for defects
✅ Refund processed in 3-5 business days

❌ Not eligible: used items, final sale, personalized items

**Process:** Contact us → Send photos → Approved within 24h → Ship back → Get refund

Which product would you like to return?`,

        default: `I can help you with:
• 🛍️ Product search & recommendations
• 📦 Order tracking & delivery status
• 🏷️ Discount codes & promotions
• 📋 Return policy & warranty

What can I help you with?`
    }
};

function initDemoChat() {
    const input = document.getElementById('demoInput');
    const sendBtn = document.getElementById('demoSend');
    const suggestions = document.querySelectorAll('.suggestion-btn');

    if (!input || !sendBtn) return;

    sendBtn.addEventListener('click', () => sendDemoMessage(input.value));
    input.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') sendDemoMessage(input.value);
    });

    suggestions.forEach(btn => {
        btn.addEventListener('click', () => {
            sendDemoMessage(btn.textContent);
        });
    });
}

function sendDemoMessage(text) {
    text = text.trim();
    if (!text) return;

    const messagesEl = document.getElementById('demoMessages');
    const input = document.getElementById('demoInput');
    const suggestionsEl = document.getElementById('demoSuggestions');

    // Add customer message
    const customerMsg = document.createElement('div');
    customerMsg.className = 'message customer';
    customerMsg.innerHTML = `<span>${escapeHtml(text)}</span>`;
    messagesEl.appendChild(customerMsg);

    input.value = '';
    suggestionsEl.style.display = 'none';

    // Add typing indicator
    const typing = document.createElement('div');
    typing.className = 'typing-indicator';
    typing.innerHTML = '<span></span><span></span><span></span>';
    messagesEl.appendChild(typing);
    messagesEl.scrollTop = messagesEl.scrollHeight;

    // Simulate AI response after delay
    setTimeout(() => {
        typing.remove();
        const response = getResponse(text);
        const botMsg = document.createElement('div');
        botMsg.className = 'message bot';
        botMsg.innerHTML = `<span>${formatMessage(response)}</span>`;
        messagesEl.appendChild(botMsg);
        messagesEl.scrollTop = messagesEl.scrollHeight;
    }, 1200);
}

function getResponse(text) {
    const lower = text.toLowerCase();
    const lang = document.documentElement.lang || 'vi';
    const responses = demoResponses[lang] || demoResponses.vi;

    for (const [key, value] of Object.entries(responses)) {
        if (key !== 'default' && lower.includes(key)) {
            return value;
        }
    }
    return responses.default;
}

function formatMessage(text) {
    return text
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
        .replace(/\n/g, '<br>');
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

// ==================== CTA Form ====================
function initCTAForm() {
    const form = document.getElementById('ctaForm');
    if (!form) return;

    form.addEventListener('submit', (e) => {
        e.preventDefault();
        const email = document.getElementById('ctaEmail').value;
        const phone = document.getElementById('ctaPhone').value;

        // In production, send to your backend/email service
        const lang = document.documentElement.lang || 'vi';
        const msg = lang === 'vi'
            ? `Cảm ơn bạn! Chúng tôi sẽ liên hệ qua ${email} trong 24 giờ.`
            : `Thank you! We'll contact you at ${email} within 24 hours.`;

        alert(msg);
        form.reset();
    });
}

// ==================== Mobile Menu ====================
function initMobileMenu() {
    const btn = document.getElementById('mobileMenuBtn');
    const navLinks = document.querySelector('.nav-links');
    if (!btn || !navLinks) return;

    btn.addEventListener('click', () => {
        navLinks.style.display = navLinks.style.display === 'flex' ? 'none' : 'flex';
        navLinks.style.flexDirection = 'column';
        navLinks.style.position = 'absolute';
        navLinks.style.top = '100%';
        navLinks.style.left = '0';
        navLinks.style.right = '0';
        navLinks.style.background = 'white';
        navLinks.style.padding = '20px';
        navLinks.style.boxShadow = '0 4px 12px rgba(0,0,0,0.1)';
    });
}

// ==================== Smooth Scroll ====================
function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', (e) => {
            e.preventDefault();
            const target = document.querySelector(anchor.getAttribute('href'));
            if (target) {
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                // Close mobile menu if open
                const navLinks = document.querySelector('.nav-links');
                if (window.innerWidth <= 768 && navLinks) {
                    navLinks.style.display = 'none';
                }
            }
        });
    });
}
