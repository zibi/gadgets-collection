class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gadget
  
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  
  def index
    @images = @gadget.images
  end
  
  
  def show
  end
  
  def new
    @image = Image.new
  end


  def create
    @image = @gadget.images.create image_params
    if @image.valid?
      redirect_to [@gadget, @image]
    else
      render :new
    end
  end

  def update
    if @image.update(image_params)
      redirect_to [@gadget, @image]
    else
      render :edit
    end
  end
  
  def destroy
    @image.destroy
    redirect_to gadget_images_url(@gadget)
  end

  private
  
  def set_gadget
    @gadget = current_user.gadgets.find(params[:gadget_id])
  end
  
  def set_image
    @image = @gadget.images.find(params[:id])
  end
  
  def image_params
    params.require(:image).permit(:title, :content)
  end
end
