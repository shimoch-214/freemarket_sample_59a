class ItemsController < ApplicationController
  layout "application"

  def index
    @popular_items = popular_items_setting
    @items = popular_items(@popular_items)
  end

  def new
    @item = Item.new
    @item.build_transact
  end

  def create
  end

  def show
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