# frozen_string_literal: true

require "ostruct"

RSpec.describe MycoPricingEngine::Calculator do
  let(:default_config) do
    {
      loyalty_threshold: 1000,
      loyalty_discount: 0.10,
      tax_rate: 0.18,
      coupons: {
        "SAVE50" => 50,
        "NEW10"  => 0.10
      }
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
    let(:user) { OpenStruct.new(loyalty_points: 1500) }

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
        options: { coupon: "SAVE50" },
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
        options: { coupon: "NEW10" },
        config: default_config
      )
      # base 1000 + 18% tax = 1180 ; -10% of 1180 = 1062
      expect(calc.final_price).to eq(1062.0)
    end
  end

  context "when loyalty, tax, and coupon all apply" do
    let(:user) { OpenStruct.new(loyalty_points: 2000) }

    it "applies all rules in correct order" do
      calc = described_class.new(
        base_price: 2000,
        user: user,
        options: { coupon: "SAVE50" },
        config: default_config
      )
      # base 2000 -10% = 1800 ; +18% tax = 2124 ; -50 coupon = 2074
      expect(calc.final_price).to eq(2074.0)
    end
  end
end
