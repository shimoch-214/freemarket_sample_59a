class UploadTestsController < ApplicationController
  def index
    @images = UploadTest.all
    @uploadtest = UploadTest.new
  end

  def create
    UploadTest.create(create_params)
    redirect_to root_path
  end

  private
  def create_params
    params.require(:upload_test).permit(:image)
  end
end
