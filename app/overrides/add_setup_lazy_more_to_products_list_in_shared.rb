
  Deface::Override.new(:virtual_path=>'spree/shared/_products',
                       :name => 'add_setup_lazy_more_to_products_in_shared',
                       :replace  =>"div.script",
                       :text         =>"<script>setuplazy()</script>")

  Deface::Override.new(:virtual_path=>'spree/shared/_products_list_infinite',
                       :name => 'replace_content_product_list',
                       :replace =>"div.col-md-3",
                       :text         => '<div class = "col-md-3 product-list-item">
              <div class="col lazy-partial"  data-lazy-url="<%= lazy_product_path(product.id)%>" >
                <div id="product_<%= product.id %>" class="single-product =<%=cycle("alpha", "secondary", "", "omega secondary", :name => "classes") %>"
  data-hook="products_list_item" itemscope itemtype="http://schema.org/Product">
                                           <i class="fa fa-fw fa-3x fa-refresh fa-spin icon-center"></i>

                </div>
  </div>
            </div>')