class ImagesController < ApplicationController
  def new; end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to @image, notice: 'Image uploaded successfully'
    else
      render :new
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  def index
    @tag = index_params
    @images = Image.tagged_with(@tag).order(created_at: :desc)
  end

  private

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end

  def index_params
    params.require(:tag)
  end
end
