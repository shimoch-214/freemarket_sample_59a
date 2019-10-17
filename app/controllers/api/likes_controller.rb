class Api::LikesController < ApplicationController
def create
  @item = Item.find(params[:item_id])
  @like =Like.create(user_id: current_user.id,item_id:params[:item_id])

end

def destroy
  @like= current_user.likes.find_by(item_id:params[:item_id])
  @like.destroy
  @item = Item.find(params[:item_id])
end

end