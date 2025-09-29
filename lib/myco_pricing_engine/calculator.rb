# frozen_string_literal: true

module MycoPricingEngine
  class Calculator
    attr_reader :base_price, :user, :options, :config

    def initialize(base_price:, user:, options: {}, config: {})
      @base_price = base_price
      @user       = user
      @options    = options
      @config     = default_config.merge(config)
    end

    def final_price
      price = base_price
      price -= loyalty_discount(price)
      price += tax(price)
      price -= coupon_discount(price)
      price.round(2)
    end

    private

    def default_config
      {
        loyalty_threshold: 1000,
        loyalty_discount: 0.10,
        tax_rate: 0.18,
        coupons: {}
      }
    end

    def loyalty_discount(price)
      return 0 unless user.respond_to?(:loyalty_points)

      if user.loyalty_points > config[:loyalty_threshold]
        price * config[:loyalty_discount]
      else
        0
      end
    end

    def tax(price)
      price * config[:tax_rate]
    end

    def coupon_discount(price)
      coupon_code = options[:coupon]
      return 0 unless coupon_code && config[:coupons].key?(coupon_code)

      discount_value = config[:coupons][coupon_code]
      if discount_value.is_a?(Numeric) && discount_value <= 1.0
        price * discount_value
      else
        discount_value
      end
    end
  end
end
