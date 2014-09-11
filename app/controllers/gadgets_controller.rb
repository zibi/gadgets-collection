class GadgetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @gadgets = current_user.gadgets
  end

  def show
    @gadget = current_user.gadgets.find(params[:id])
  end

  def edit
    @gadget = current_user.gadgets.find(params[:id])
  end

  def new
    @gadget = Gadget.new
  end

  def create
    @gadget = current_user.gadgets.create params.require(:gadget).permit(:name, :description)
    if @gadget.valid?
      redirect_to @gadget
    else
      render :new
    end
  end
  
  def update
    @gadget = current_user.gadgets.find(params[:id])
    if @gadget.update(params.require(:gadget).permit(:name, :description))
      redirect_to @gadget
    else
      render :edit
    end
  end
  
  
  def destroy
    @gadget = current_user.gadgets.find(params[:id])
    @gadget.destroy
    redirect_to gadgets_url
  end
end
