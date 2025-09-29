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
user = User.new(loyalty_points: 1200) # Active Record/Openstruct

# Optional configuration
config = {
  loyalty_threshold: 1000,   # Points required for loyalty discount
  loyalty_discount: 0.10,    # 10% discount
  tax_rate: 0.18,            # 18% tax
  coupons: {                 # Coupon codes
    "SAVE50" => 50,          # Fixed discount
    "NEW10"  => 0.10         # Percentage discount
  }
}

# Initialize calculator
calc = MycoPricingEngine::Calculator.new(
  base_price: 1000,
  user: user,
  options: { coupon: "SAVE50" },
  config: config
)

# Calculate final price
puts calc.final_price
# => 1062.0

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

