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
  
  describe "GET show" do
    context 'user is not signed in' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      let(:user) { create(:user) }

      before :each do
        sign_in user
      end

      context "gadget exists" do
        let(:gadget) { create(:gadget, user: user)}

        it 'is successfull' do
          get :show, id: gadget.to_param
          expect(response).to have_http_status(:success)          
        end

        it 'renders show template' do
          get :show, id: gadget.to_param
          expect(response).to render_template(:show)
        end
        
        it 'assigns gadget' do
          get :show, id: gadget.to_param
          expect(assigns(:gadget)).to eq gadget
        end
      end

      context "gadget does not exist" do
        it 'raises not found exception' do
          expect { get :show, id: 1}.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
  
  
  describe "GET edit" do
    context 'user is not signed in' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      let(:user) { create(:user) }

      before :each do
        sign_in user
      end

      context "gadget exists" do
        let(:gadget) { create(:gadget, user: user)}

        it 'is successfull' do
          get :edit, id: gadget.to_param
          expect(response).to have_http_status(:success)          
        end

        it 'renders edit template' do
          get :edit, id: gadget.to_param
          expect(response).to render_template(:edit)
        end
      
        it 'assigns gadget' do
          get :edit, id: gadget.to_param
          expect(assigns(:gadget)).to eq gadget
        end        
      end

      context "gadget does not exist" do
        it 'raises not found exception' do
          expect { get :show, id: 1}.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
  
  
  describe "GET new" do
    context 'user is not signed in' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      let(:user) { create(:user) }

      before :each do
        sign_in user
      end
      
      it 'is successfull' do
        get :new
        expect(response).to have_http_status(:success)
      end
      
      it 'renders new template' do
        get :new
        expect(response).to render_template(:new)
      end
      
      it 'assigns new instance of Gadget' do
        get :new
        expect(assigns(:gadget)).to be_a_new(Gadget)
      end
    end
  end
end
