class Api::ItemsImageController < ApplicationController
  layout false

  def image
    @image = Image.create(img_params)
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    render body: nil
  end

  private
  
  def img_params
    params.permit(:name)
  end
end