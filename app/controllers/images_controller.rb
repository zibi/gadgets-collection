class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gadget
  
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  
  def index
    @images = @gadget.images
  end
  
  
  def show
  end
  
  private
  
  def set_gadget
    @gadget = current_user.gadgets.find(params[:gadget_id])
  end
  
  def set_image
    @image = @gadget.images.find(params[:id])
  end
end
