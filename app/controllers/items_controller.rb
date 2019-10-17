class ItemsController < ApplicationController
  layout "application-user", only: [:new, :create, :edit, :update]
  before_action :get_item, only: [:edit, :update, :show, :destroy]
  before_action :move_to_sign_in, except: [:index, :show, :search], unless: :user_signed_in?
  before_action :current_user_is_seller?, only: [:edit, :update, :destroy]
  before_action :status_is_zero?, only: [:edit, :update, :destroy]

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
      render :new
    end
  end

  def show
    seller_item_ids = Transact.where(seller_id: @item.seller.id).pluck(:id)
    seller_item_ids.delete(@item.id)
    @user_items =Item.where(id: seller_item_ids).page(params[:page]).per(6).order("created_at DESC")
    category_item_ids = @item.category.sibling_ids
    category_item_ids.delete(@item.category.id)
    @category_items = Item.where(category_id: category_item_ids).page(params[:page]).per(6).order("created_at DESC")
    @like=@item.likes
  end

  def edit
    render :new
  end

  def update
    @item.add_images(params[:image_ids])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      @item.add_category(category_params)
      render :new
    end
  end

  def destroy
    @item.destroy
    redirect_to mypage_path
  end

  def search
    @keyword = params[:q][:name_or_description_cont]
    @search_items = @q.result.includes(:images, :transact, :sizing, :category).page(params[:page]).per(40).order("created_at DESC")
    @items = Item.page(params[:page]).per(24).order("created_at DESC") if @search_items.blank? || @keyword.blank?
    @category = Category.where(ancestry: nil)
    @sizing = Sizing.where(ancestry: nil)
  end

  private

  def get_item
    @item = Item.find(params[:id])
  end

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
        :ship_days,
      ]
    )
  end

  def category_params
    params.permit(
      :parent_id,
      :child_id,
    )
  end

  def move_to_sign_in
    redirect_to user_sessions_new_path
  end

  def current_user_is_seller?
    unless current_user.id == @item.seller.id
      flash.now[:danger] = '不正なリクエストです' 
      redirect_to root_path
    end
  end

  def status_is_zero?
    unless @item.transact.status_before_type_cast == 0
      flash.now[:danger] = '不正なリクエストです' 
      redirect_to root_path
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