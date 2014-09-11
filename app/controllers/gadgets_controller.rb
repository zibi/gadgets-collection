class GadgetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @gadgets = current_user.gadgets
  end
end
