Spree::Core::Engine.routes.draw do
  get "/lazy/product/:id" => 'api/lazy#product', as: :lazy_product
end
