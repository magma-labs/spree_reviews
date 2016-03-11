module Spree::ReviewsHelper
  def star(the_class)
    content_tag(:span, ' &#10030; '.html_safe, class: the_class)
  end

  def mk_stars(m)
    (1..5).collect { |n| n <= m ? star('lit') : star('unlit') }.join
  end

  def txt_stars(n, show_out_of = true)
    res = Spree.t(:star, count: n)
    res += " #{Spree.t('out_of_5')}" if show_out_of
    res
  end

  # the per_page_dropdown is used on index pages like orders, products, promotions etc.
  # this method generates the select_tag
  def per_page_dropdown
    # there is a config setting for admin_products_per_page, only for the orders page
    if @products && per_page_default = Spree::Config.admin_products_per_page
      per_page_options = []
      5.times do |amount|
        per_page_options << (amount + 1) * Spree::Config.admin_products_per_page
      end
    else
      per_page_default = 15
      per_page_options = %w{5 15 30 45 60}
    end

    select_tag(:per_page,
               options_for_select(per_page_options, params['per_page'] || per_page_default),
               { class: "form-control pull-right js-per-page-select" })
  end
end
