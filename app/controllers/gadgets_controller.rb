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
end
