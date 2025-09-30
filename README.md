# 🚀 Myco Pricing Engine – Rails Engine for Pricing Utilities

[![Gem Version](https://badge.fury.io/rb/myco_pricing_engine.svg)](https://rubygems.org/gems/myco_pricing_engine)
[![Build Status](https://github.com/your-username/myco_pricing_engine/actions/workflows/ci.yml/badge.svg)](https://github.com/your-username/myco_pricing_engine/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Myco Pricing Engine** is an open-source **Rails engine** that provides utilities for pricing calculations and automation.
It helps developers integrate pricing logic, split EMIs, and manage financial calculations in Rails applications.

👉 [RubyGems page](https://rubygems.org/gems/myco_pricing_engine) |
👉 [Source code on GitHub](https://github.com/your-username/myco_pricing_engine)

---

## ✨ Features
- ⚡ Automatic pricing calculations
- 🔢 EMI and interest rate utilities
- 🧩 Easily integratable with Rails apps

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
  tax_rate: 0.18,
  coupons: {
    "SAVE50" => 50,    # Fixed discount
    "NEW10"  => 0.10   # Percentage discount
  },
  delivery_fee: 50.0
}

# Initialize calculator
calc = MycoPricingEngine::Calculator.new(
  base_price: 1000,
  user: user,
  options: { coupons: ["SAVE50"] }, # <-- note: array of coupon codes
  config: config
)

# Calculate final price
puts calc.final_price
# => 1130.0
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

