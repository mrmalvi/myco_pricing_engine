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

      # Apply discounts
      price -= loyalty_discount(price)
      price -= early_bird_discount(price)

      # Add tax
      price += tax(price)

      # Apply coupons (after tax)
      price -= coupon_discounts(price)

      # Add delivery/service fee
      price += delivery_fee

      # Apply caps
      price = apply_price_caps(price)

      price.round(2)
    end

    private

    def default_config
      {
        # Loyalty
        loyalty_levels: {
          silver:   { threshold: 500,  discount: 0.05 },
          gold:     { threshold: 1000, discount: 0.10 },
          platinum: { threshold: 2000, discount: 0.20 }
        },

        # Tax
        tax_rate: 0.18,

        # Coupons
        coupons: {},

        # Early bird
        early_bird_deadline: nil, # Date or Time
        early_bird_discount: 0.10,

        # Fees
        delivery_fee: 0.0,

        # Caps
        min_price: 0.0,
        max_price: Float::INFINITY
      }
    end

    # ---------------------
    # Discounts
    # ---------------------
    def loyalty_discount(price)
      return 0 unless user.respond_to?(:loyalty_points)

      discount = 0
      config[:loyalty_levels].each_value do |level|
        if user.loyalty_points >= level[:threshold]
          discount = level[:discount]
        end
      end

      price * discount
    end

    def coupon_discounts(price)
      return 0 unless options[:coupons].is_a?(Array)

      options[:coupons].sum do |code|
        next 0 unless config[:coupons].key?(code)

        discount_value = config[:coupons][code]
        if discount_value.is_a?(Numeric) && discount_value <= 1.0
          price * discount_value
        else
          discount_value
        end
      end
    end

    def early_bird_discount(price)
      deadline = config[:early_bird_deadline]
      return 0 unless deadline && current_time <= deadline

      price * config[:early_bird_discount]
    end

    # ---------------------
    # Fees & Tax
    # ---------------------
    def tax(price)
      price * config[:tax_rate]
    end

    def delivery_fee
      config[:delivery_fee].to_f
    end

    # ---------------------
    # Caps
    # ---------------------
    def apply_price_caps(price)
      [[price, config[:min_price]].max, config[:max_price]].min
    end

    def current_time
      if defined?(Time.zone) && Time.zone
        Time.current
      else
        Time.now
      end
    end
  end
end
