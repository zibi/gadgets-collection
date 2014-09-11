require 'rails_helper'

RSpec.describe GadgetsController, :type => :controller do

  describe "GET index" do

    context 'user is not signed in' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      let(:user) { create(:user) }
      let(:gadget1) { create(:gadget, user: user) }
      let(:gadget2) { create(:gadget, user: user) }

      let(:other_user) { create(:user) }
      let(:other_gadget) { create(:gadget, user: other_user) }
      let(:gadgets) { [] }

      before :each do
        sign_in user
      end

      it 'is successfull' do
        get :index
        expect(response).to have_http_status(:success)
      end
      
      it 'renders index template' do
        get :index
        expect(response).to render_template(:index)
      end
      
      it 'assings gadgets of the signed in user' do
        get :index
        expect(assigns(:gadgets)).to include(gadget1, gadget2)
      end
      
      it 'does not assign other users gadgets' do
        get :index
        expect(assigns(:gadgets)).to_not include(other_gadget)
      end
    end
  end
end
