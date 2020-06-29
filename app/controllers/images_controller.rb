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
    @tag = params[:tag]
    @images = if @tag.nil?
                Image.all.order(created_at: :desc)
              else
                Image.tagged_with(@tag).order(created_at: :desc)
              end
  end

  private

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end
end
