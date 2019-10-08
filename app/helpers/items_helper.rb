module ItemsHelper
  def modify_label(image_size)
    if image_size < 5
      image_size.to_s
    elsif image_size >= 5 && image_size < 10
      (image_size-5).to_s
    elsif image_size == 10
      'max'
    end
  end

  def category_builder(category, sizing)
    div_children = content_tag(:div, '', class: 'items-forms__content__select-wrap', id: 'children-select-box')
    div_grand_children = content_tag(:div, '', class: 'items-forms__content__select-wrap', id: 'grand-children-select-box')
    div_sizing = content_tag(:div, '', id: 'sizing-wrapper')
    if category.nil?
      parents = options_for_select(Category.roots.map{ |ele| [ele.name, ele.id]})
      parent_html = content_tag :div, class: 'items-forms__content__select-wrap' do
        render partial: 'api/categories/select_tag', locals: { options: parents, resource: 'parent' }
      end
      return  parent_html + div_children + div_grand_children + div_sizing
    elsif category.depth == 0
      parents = options_for_select(Category.roots.map{ |ele| [ele.name, ele.id]}, selected: category.id)
      children = options_for_select(category.children.map{ |ele| [ele.name, ele.id]})
      parent_html = content_tag :div, class: 'items-forms__content__select-wrap' do
        render partial: 'api/categories/select_tag', locals: { options: parents, resource: 'parent' }
      end
      child_html = content_tag :div, class: 'items-forms__content__select-wrap', id: 'children-select-box' do
        render partial: 'api/categories/select_tag', locals: { options: children, resource: 'child' }
      end
      return parent_html + child_html + div_grand_children + div_sizing
    elsif category.depth == 1
      parents = options_for_select(Category.roots.map{ |ele| [ele.name, ele.id]}, selected: category.parent.id)
      children = options_for_select(category.siblings.map{ |ele| [ele.name, ele.id]}, selected: category.id)
      grand_children = options_for_select(category.children.map{ |ele| [ele.name, ele.id]})
      parent_html = content_tag :div, class: 'items-forms__content__select-wrap' do
        render partial: 'api/categories/select_tag', locals: { options: parents, resource: 'parent' }
      end
      child_html = content_tag :div, class: 'items-forms__content__select-wrap', id: 'children-select-box' do
        render partial: 'api/categories/select_tag', locals: { options: children, resource: 'child' }
      end
      grand_child_html = content_tag :div, class: 'items-forms__content__select-wrap', id: 'grand-children-select-box' do
        render partial: 'api/categories/select', locals: { options: grand_children, model: :item, attr: :category_id }
      end
      if category.has_children?
        return parent_html + child_html + grand_child_html + div_sizing
      else
        return parent_html + child_html + div_grand_children + div_sizing
      end
    elsif category.depth == 2
      parents = options_for_select(Category.roots.map{ |ele| [ele.name, ele.id]}, selected: category.root.id)
      children = options_for_select(category.parent.siblings.map{ |ele| [ele.name, ele.id]}, selected: category.parent.id)
      grand_children = options_for_select(category.siblings.map{ |ele| [ele.name, ele.id]}, selected: category.id)
      parent_html = content_tag :div, class: 'items-forms__content__select-wrap' do
        render partial: 'api/categories/select_tag', locals: { options: parents, resource: 'parent' }
      end
      child_html = content_tag :div, class: 'items-forms__content__select-wrap', id: 'children-select-box' do
        render partial: 'api/categories/select_tag', locals: { options: children, resource: 'child' }
      end
      grand_child_html = content_tag :div, class: 'items-forms__content__select-wrap', id: 'grand-children-select-box' do
        render partial: 'api/categories/select', locals: { options: grand_children, model: :item, attr: :category_id }
      end
      sizing_html = content_tag :div, id: 'sizing-wrapper' do
        if sizing
          render partial: 'api/categories/sizing', locals: { sizings: category.sizing.children, sizing_id: sizing.id }
        else
          if category.sizing
            render partial: 'api/categories/sizing', locals: { sizings: category.sizing.children, sizing_id: '' }
          else
            div_sizing
          end
        end
      end
      return parent_html + child_html + grand_child_html + sizing_html
    end
  end

  def delivery_method_builder(bearing, delivery_method)
    if bearing
      content_tag :div, id: 'delivery_method-wrapper' do
        if bearing == 'seller_side'
          options = Transact.delivery_methods
        elsif bearing == 'buyer_side'
          options = Transact.delivery_methods_for_buyer_side
        end
        render partial: 'api/transacts/delivery_method_selector', locals: { options: options, delivery_method: delivery_method}
      end
    else
      content_tag(:div, '', id: 'delivery_method-wrapper')
    end
  end
end
