module Spree
  module Api
    class LazyController < ActionController::Base
      include Spree::Core::ControllerHelpers::Pricing
      include Spree::Core::ControllerHelpers::Store

      def product

        I18n.locale = session[:locale] = params[:locale]
        @product = Spree::Product.includes(:variant_images, :taxons, :master_variant, {in_stock_variants: { active_sale_prices: {}, stock_items: {}, option_values:{translations: {}, option_type: :translations} }}).find(params[:id])


        render partial: "spree/shared/single_product", locals:{:product => @product}, :layout => false
      end
    end
  end
end