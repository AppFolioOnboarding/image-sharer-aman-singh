class ImagesController < ApplicationController
  def new; end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to @image, notice: 'Image uploaded successfully'
    else
      # TODO: Question: Why does this take us to GET /images url which opens new.html
      render :new
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  private

  def image_params
    params.require(:image).permit(:url)
  end
end
