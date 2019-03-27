Spree::Price.class_eval do

  has_many :active_sale_prices, -> { where(enabled: true).where('(start_at <= ? OR start_at IS NULL) AND (end_at >= ? OR end_at IS NULL)', Time.now, Time.now) }, class_name: "Spree::SalePrice"
  def active_sale
    first_sale(active_sale_prices) if on_sale?
  end

  def on_sale?
    active_sale_prices.present? && first_sale(active_sale_prices).value < original_price
  end

end 