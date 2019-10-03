class ItemsController < ApplicationController
  layout "application-user", only: :new
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @popular_items = popular_items_setting
    @items = popular_items(@popular_items)
  end

  def new
    @item = Item.new
    @item.build_transact
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    @item.transact.seller = current_user
    if @item.save
      redirect_to item_path(@item)
    else
      @item.images.build if @item.images.empty?
      render 'new'
    end
  end

  def show
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
        :bearing,
        :delivery_method,
        :prefecture_id,
        :ship_days
      ],
      images_attributes: [
        :name
      ]
    )
  end

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
        items[a_genre] = Item.where(category_id: grandchild_ids).page(params[:page]).per(10).order("created_at DESC")
      end
    else
      genre.each do |a_genre|
        items[a_genre] = Item.where(brand: a_genre).page(params[:page]).per(10).order("created_at DESC")
      end
    end
  end
  return items
end