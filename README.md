# MycoPricingEngine

MycoPricingEngine is a Ruby gem for handling **pricing calculations, loan/EMI computations, and financial preference management** in Rails applications. It provides a flexible engine for modeling pricing rules, calculating interest, and managing dynamic preferences per entity.

## Installation

You can install the gem by adding it to your application's Gemfile:

```ruby
# From RubyGems
gem 'myco_pricing_engine'

# Or directly from GitHub
gem 'myco_pricing_engine', git: 'https://github.com/mrmalvi/myco_pricing_engine.git'
```

Then execute:

```bash
bundle install
```

Or install it manually:

```bash
gem install myco_pricing_engine
```

## Usage

### 1. Including Pricing Engine in Rails Models

```ruby
class Loan < ApplicationRecord
  include MycoPricingEngine::Calculator

  # Example: calculate EMI
  def monthly_emi
    MycoPricingEngine::Calculator.compute_emi(principal, rate_of_interest, tenure)
  end
end
```

### 2. Managing Preferences

The gem supports dynamic preferences using `SerialPreference`:

```ruby
class DummyClass < ApplicationRecord
  include SerialPreference::HasSerialPreferences

  preferences do
    boolean :taxable, default: true
    string  :vat_no
    integer :max_invoice_items, default: 100
  end
end

d = DummyClass.new
d.taxable?           # => true
d.vat_no = "ABC123"
d.max_invoice_items   # => 100
```

### 3. Supported Rails Versions

MycoPricingEngine supports:

- Rails 4.x → 7.x
- ActiveRecord 4.x → 8.x
- Ruby 2.7+ → 3.4

### 4. Development

Clone the repository and set up dependencies:

```bash
git clone https://github.com/mrmalvi/myco_pricing_engine.git
cd myco_pricing_engine
bin/setup
```

Run the console to experiment:

```bash
bin/console
```

Run tests:

```bash
bundle exec rspec
```

To install the gem locally:

```bash
bundle exec rake install
```

To release a new version:

```bash
# Update the version in lib/myco_pricing_engine/version.rb
bundle exec rake release
```

This will create a git tag, push commits, and push the gem to RubyGems.org.

## Contributing

Bug reports and pull requests are welcome! Please open issues or PRs on [GitHub](https://github.com/mrmalvi/myco_pricing_engine).

Before contributing, ensure all tests pass:

```bash
bundle exec rspec
```

## License

This gem is released under the MIT License. See [LICENSE](LICENSE) for details.

