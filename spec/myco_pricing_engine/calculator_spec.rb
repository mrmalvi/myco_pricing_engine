# frozen_string_literal: true

require "ostruct"

RSpec.describe MycoPricingEngine::Calculator do
  let(:default_config) do
    {
      loyalty_levels: {
        silver:   { threshold: 500,  discount: 0.05 },
        gold:     { threshold: 1000, discount: 0.10 },
        platinum: { threshold: 2000, discount: 0.20 }
      },
      tax_rate: 0.18,
      coupons: {
        "SAVE50" => 50,
        "NEW10"  => 0.10
      },
      early_bird_deadline: nil,
      early_bird_discount: 0.10,
      delivery_fee: 0.0,
      min_price: 0.0,
      max_price: Float::INFINITY
    }
  end

  context "when no discounts or coupons apply" do
    let(:user) { OpenStruct.new(loyalty_points: 100) }

    it "applies only tax" do
      calc = described_class.new(base_price: 1000, user: user, config: default_config)
      expect(calc.final_price).to eq(1180.0) # 1000 + 18% tax
    end
  end

  context "when loyalty discount applies" do
    let(:user) { OpenStruct.new(loyalty_points: 1500) } # gold level

    it "applies loyalty discount and tax" do
      calc = described_class.new(base_price: 1000, user: user, config: default_config)
      # 1000 - 10% = 900 ; +18% tax = 1062.0
      expect(calc.final_price).to eq(1062.0)
    end
  end

  context "when fixed coupon applies" do
    let(:user) { OpenStruct.new(loyalty_points: 100) }

    it "applies coupon after tax" do
      calc = described_class.new(
        base_price: 1000,
        user: user,
        options: { coupons: ["SAVE50"] },
        config: default_config
      )
      # base 1000 + 18% tax = 1180 ; - 50 coupon = 1130
      expect(calc.final_price).to eq(1130.0)
    end
  end

  context "when percentage coupon applies" do
    let(:user) { OpenStruct.new(loyalty_points: 100) }

    it "applies percentage coupon after tax" do
      calc = described_class.new(
        base_price: 1000,
        user: user,
        options: { coupons: ["NEW10"] },
        config: default_config
      )
      # base 1000 + 18% tax = 1180 ; -10% of 1180 = 1062
      expect(calc.final_price).to eq(1062.0)
    end
  end

  context "when loyalty, tax, and coupon all apply" do
    let(:user) { OpenStruct.new(loyalty_points: 2000) } # platinum level (20%)

    it "applies all rules in correct order" do
      calc = described_class.new(
        base_price: 2000,
        user: user,
        options: { coupons: ["SAVE50"] },
        config: default_config
      )
      # base 2000 -20% = 1600 ; +18% tax = 1888 ; -50 coupon = 1838
      expect(calc.final_price).to eq(1838.0)
    end
  end

  context "when early bird discount applies" do
    let(:user) { OpenStruct.new(loyalty_points: 0) }
    let(:config) { default_config.merge(early_bird_deadline: Time.now + 1.hour) }

    it "applies early bird discount" do
      calc = described_class.new(base_price: 1000, user: user, config: config)
      # 1000 -10% = 900 ; +18% tax = 1062
      expect(calc.final_price).to eq(1062.0)
    end
  end

  context "when delivery fee applies" do
    let(:user) { OpenStruct.new(loyalty_points: 0) }
    let(:config) { default_config.merge(delivery_fee: 50) }

    it "adds delivery fee" do
      calc = described_class.new(base_price: 1000, user: user, config: config)
      # 1000 +18% tax = 1180 ; +50 delivery = 1230
      expect(calc.final_price).to eq(1230.0)
    end
  end

  context "when price caps apply" do
    let(:user) { OpenStruct.new(loyalty_points: 0) }
    let(:config) { default_config.merge(max_price: 1100, min_price: 500) }

    it "caps the price at max_price" do
      calc = described_class.new(base_price: 1000, user: user, config: config)
      # normal = 1180, but capped to 1100
      expect(calc.final_price).to eq(1100.0)
    end
  end
end
