class ItemsController < ApplicationController
  layout "application-user", only: [:new, :create]
  before_action :authenticate_user!, except: [:index, :search]

  def index
    @popular_items = popular_items_setting
    @items = popular_items(@popular_items)
  end

  def new
    @item = Item.new
    @item.build_transact
  end

  def create
    @item = Item.new(item_params)
    @item.transact.seller = current_user
    @item.add_images(params[:image_ids])
    if @item.save
      redirect_to item_path(@item)
    else
      @item.add_category(category_params)
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
    seller_item_ids = Transact.where(seller_id: @item.seller.id).pluck(:id)
    seller_item_ids.delete(@item.id)
    @user_items =Item.where(id: seller_item_ids).page(params[:page]).per(6).order("created_at DESC")
    category_item_ids = @item.category.sibling_ids
    category_item_ids.delete(@item.category.id)
    @category_items = Item.where(category_id: category_item_ids).page(params[:page]).per(6).order("created_at DESC")
  end

  def edit
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to mypage_path
  end

  def search
    @keyword = params[:q][:name_or_description_cont]
    @search_items = @q.result.includes(:images, :transact, :sizing, :category).page(params[:page]).per(3).order("created_at DESC")
    @items = Item.page(params[:page]).per(24).order("created_at DESC") if @search_items.blank? || @keyword.blank?
    @category = Category.where(ancestry: nil)
    @sizing = Sizing.where(ancestry: nil)
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :category_id,
      :sizing_id,
      :condition,
      :price,
      transact_attributes: [
        :seller_id,
        :buyer_id,
        :bearing,
        :delivery_method,
        :prefecture_id,
        :ship_days,
        :status
      ]
    )
  end

  def category_params
    params.permit(
      :parent_id,
      :child_id,
    )
  end

  # 人気のカテゴリー、ブランドの種類を設定
  def popular_items_setting
    return {
      category: ["レディース", "メンズ", "家電・スマホ・カメラ", "おもちゃ・ホビー・グッズ"],
      brand: ["シャネル", "ルイヴィトン", "シュプリーム", "ナイキ"]
    }
  end
  
  # 設定したカテゴリー、ブランドをハッシュキーにして、itemレコードを取得
  def popular_items(popular_genre)
    items = {}
    popular_genre.each do |item_tag, genre|
      if item_tag == :category
        genre.each do |a_genre|
          grandchild_ids = Category.where(name: a_genre).first.indirect_ids
          items[a_genre] = Item&.where(category_id: grandchild_ids).page(params[:page]).per(10).order("created_at DESC")
        end
      else
        genre.each do |a_genre|
          items[a_genre] = Item&.where(brand: a_genre).page(params[:page]).per(10).order("created_at DESC")
        end
      end
    end
    return items
  end
end