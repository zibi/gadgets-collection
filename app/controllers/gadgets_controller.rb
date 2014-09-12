class GadgetsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_gadget, only: [:show, :edit, :update, :destroy]

  def index
    @gadgets = current_user.gadgets
  end

  def search
    @gadgets = current_user.gadgets.where(['name LIKE ?', "%#{params.require(:query)}%"])
  end

  def flow
    @images = current_user.images
  end

  def show
  end

  def edit
  end

  def new
    @gadget = Gadget.new
  end

  def create
    @gadget = current_user.gadgets.create gadgets_params
    if @gadget.valid?
      redirect_to @gadget
    else
      render :new
    end
  end
  
  def update
    if @gadget.update(gadgets_params)
      redirect_to @gadget
    else
      render :edit
    end
  end
  
  
  def destroy
    @gadget.destroy
    redirect_to gadgets_url
  end
  
  private
  
  def gadgets_params
    params.require(:gadget).permit(:name, :description)
  end
  
  def set_gadget
    @gadget = current_user.gadgets.find(params[:id])
  end
end
