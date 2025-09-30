# 🚀 Myco Pricing Engine – Rails Engine for Pricing Utilities

[![Gem Version](https://badge.fury.io/rb/myco_pricing_engine.svg)](https://rubygems.org/gems/myco_pricing_engine)
[![Build Status](https://github.com/your-username/myco_pricing_engine/actions/workflows/ci.yml/badge.svg)](https://github.com/your-username/myco_pricing_engine/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Myco Pricing Engine is an open-source **Rails engine** designed for businesses, fintech companies, and organizations to handle pricing calculations and automation for products, services, or financial instruments. It provides reusable utilities to manage complex pricing rules, apply discounts, compute taxes, and handle promotions efficiently.

👉 [RubyGems page](https://rubygems.org/gems/myco_pricing_engine) |
👉 [Source code on GitHub](https://github.com/your-username/myco_pricing_engine)

---

## ✨ Features
⚡ Automatic pricing calculations for products, services, or financial instruments
💳 EMI, interest, and installment utilities for financial products
🏷️ Discounts: loyalty, tiered, early-bird, and multiple coupons
🧾 Taxes, delivery, and service fee calculations
🛡️ Price caps and floors to enforce business rules
🧩 Easily integratable with any Rails app

---

## 📦 Installation

Add this line to your Rails app `Gemfile`:

```ruby
gem 'myco_pricing_engine'
```

Then install the gem:

```bash
bundle install
```

Or install manually:

```bash
gem install myco_pricing_engine
```

## 🚀 Usage

### Automatic Features
- Pricing calculations for products, EMI breakdown, and financial summaries.

### Manual Usage
```ruby
require "ostruct"

# Example user (ActiveRecord model or OpenStruct with `loyalty_points`)
user = OpenStruct.new(loyalty_points: 1200)

# Optional configuration
config = {
  loyalty_levels: {
    silver:   { threshold: 500,  discount: 0.05 },
    gold:     { threshold: 1000, discount: 0.10 },
    platinum: { threshold: 2000, discount: 0.20 }
  },
  tax_rate: 0.18,                       # 18% tax
  coupons: {                             # Coupons can stack
    "SAVE50" => 50,                      # Fixed discount
    "NEW10"  => 0.10                     # Percentage discount
  },
  early_bird_deadline: Time.current + 1.hour, # Early bird active for 1 hour
  early_bird_discount: 0.05,              # 5% early bird
  delivery_fee: 20.0,                     # Delivery fee
  min_price: 0.0,
  max_price: 2000.0                       # Price cap
}

# --- Options (Coupons applied) ---
options = {
  coupons: ["SAVE50", "NEW10"] # Multiple coupons
}

# --- Initialize Calculator ---
calc = MycoPricingEngine::Calculator.new(
  base_price: 1000,
  user: user,
  options: options,
  config: config
)

# --- Calculate final price ---
final_price = calc.final_price
puts "Final Price: #{final_price}"

# --- Step-by-step calculation ---
# Base Price: 1000
# Loyalty Discount (gold 10%): 100
# Price after loyalty: 900
# Early Bird Discount (5%): 45
# Price after early bird: 855
# Tax (18%): 153.9
# Price after tax: 1008.9
# Coupons:
#   SAVE50 (fixed) = 50
#   NEW10 (percentage) = 1008.9 * 0.10 = 100.89
# Total coupon discount = 150.89
# Price after coupons: 858.01
# Delivery Fee: +20 = 878.01
# Caps applied: min 0, max 2000 → no change
# Final Price: 878.01 ✅
```

---

## 🧪 Development & Testing

Clone and setup:

```bash
git clone https://github.com/your-username/myco_pricing_engine.git
cd myco_pricing_engine
bundle install
```

Run specs:

```bash
bundle exec rspec
```

Build gem locally:

```bash
bundle exec rake install
```

Release a version:

```bash
bundle exec rake release
```

---

## 🤝 Contributing

Contributions, bug reports, and pull requests are welcome!
See [issues](https://github.com/your-username/myco_pricing_engine/issues).

---

## 📜 License

Released under the [MIT License](LICENSE.txt).

---

### 📈 SEO Keywords
*Rails engine, Ruby gem, pricing utilities, EMI calculation, Rails financial gem, Myco Pricing Engine*

