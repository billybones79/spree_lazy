Spree::Product.class_eval do


  has_many :in_stock_variants,
           -> { in_stock.where(is_master: false).order("#{::Spree::Variant.quoted_table_name}.position ASC") },
           inverse_of: :product,
           class_name: 'Spree::Variant'
  has_many :master_variant, ->{ where(is_master: true) }, class_name: 'Spree::Variant'
  def option_values
    @_option_values ||= Spree::OptionValue.includes(:translations).for_product(self)
  end
  def variants_for_option_value(value)
    @_variant_option_values ||= variants.includes(:option_values)
    @_variant_option_values.select { |i| i.option_value_ids.include?(value.id) }
  end
  def grouped_option_values
    @_grouped_option_values ||= option_values.joins(:translations, :variants, option_type: :translations).where(spree_option_values_variants:{variant_id: variants}).group_by(&:option_type)
    @_grouped_option_values.sort_by { |option_type, option_values| option_type.position }
  end
  def first_image
    variant_images.first
  end

end
