class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gadget
  
  def index
    @images = @gadget.images
  end
  
  
  def show
    @image = @gadget.images.find(params[:id])
  end
  
  private
  
  def set_gadget
    @gadget = current_user.gadgets.find(params[:gadget_id])
  end
end
