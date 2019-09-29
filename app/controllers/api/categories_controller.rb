class Api::CategoriesController < ApplicationController
  layout false

  def parent_select
    @parent = Category.find(parent_params[:parent_id])
  end
  
  def child_select
    @child = Category.find(child_params[:child_id])
    render body: nil if @child.children.empty?
  end

  def grand_child_select
    @sizing = Category.find(grand_child_params[:grand_child_id]).sizing
    render body: nil if @sizing.nil?
  end

  private
  def parent_params
    params.permit(:parent_id)
  end

  def child_params
    params.permit(:child_id)
  end

  def grand_child_params
    params.permit(:grand_child_id)
  end
end