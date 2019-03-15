module Spree
  module Api
    class LazyController < ActionController::Base
      helper_method :current_currency
      def current_currency
        Spree::Config[:currency]
      end
      def product

        I18n.locale = session[:locale] = params[:locale]
        @product = Rails.cache.fetch(["product_id", params[:locale], params[:id]], expires_in: 1.hour) do
          Spree::Product.active(Spree::Config[:currency]).includes(:variant_images, :taxons, :master_variant, {in_stock_variants: { stock_items: {}, option_values:{translations: {}, option_type: :translations} }}).find(params[:id])
        end
        render partial: "spree/shared/single_product", locals:{:product => @product}, :layout => false
      end
    end
  end
end