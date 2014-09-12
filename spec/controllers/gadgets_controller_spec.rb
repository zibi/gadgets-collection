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
        get :show, id: 1
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
        get :edit, id: 1
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
        get :new
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

  describe "POST create" do

    context 'user is not signed in' do
      it 'redirects to sign in page' do
        post :create, gadget: attributes_for(:gadget)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      let(:user) { create(:user) }

      before :each do
        sign_in user
      end

      context "with valid parameters for Gadget" do
        it 'creates new instance of Gadget' do
          expect { post :create, gadget: attributes_for(:gadget) }.to change(Gadget, :count).by(1)
        end

        it 'sets signed in user as creator of the gadget' do
          post :create, gadget: attributes_for(:gadget)
          expect(Gadget.last.user).to eq user
        end

        it 'redirects to show page for created gadget' do
          post :create, gadget: attributes_for(:gadget)
          expect(response).to redirect_to Gadget.last
        end
      end

      context "with invalid parameters for Gadget" do
        it 'does not create new instance of Gadget' do
          expect { post :create, gadget: attributes_for(:invalid_gadget) }.to_not change(Gadget, :count)
        end

        it 'renders new template' do
          post :create, gadget: attributes_for(:invalid_gadget)
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe "PUT update" do

    context 'user is not signed in' do
      it 'redirects to sign in page' do
        put :update, id: 1, gadget: attributes_for(:gadget)
        expect(response).to redirect_to(new_user_session_path)
      end
    end


    context 'user is signed in' do
      let(:user) { create(:user) }

      let(:gadget) { create(:gadget, user: user) }

      before :each do
        sign_in user
      end

      it 'assigns gadget' do
        put :update, id: gadget.to_param, gadget: attributes_for(:gadget)
        expect(assigns(:gadget)).to eq gadget
      end

      context "with valid params" do
        it 'redirects to show page' do
          put :update, id: gadget.to_param, gadget: attributes_for(:gadget)
          expect(response).to redirect_to gadget
        end

        it 'updates the gadget' do
          put :update, id: gadget.to_param, gadget: attributes_for(:gadget, name: 'updated name')
          gadget.reload
          expect(gadget.name).to eq 'updated name'
        end
      end

      context "with invalid params" do
        it 'renders edit page' do
          put :update, id: gadget.to_param, gadget: attributes_for(:invalid_gadget)
          expect(response).to render_template :edit
        end
      end
    end
  end
  
  describe "DELETE destroy" do
    context 'user is not signed in' do
      it 'redirects to sign in page' do
        delete :destroy, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    context 'user is signed in' do
      let(:user) { create(:user) }

      let(:gadget) { create(:gadget, user: user) }
      
      before :each do
        sign_in user
      end
      
      it 'destroys the gadget' do
        gadget # otherwise change matcher does not work properly 
        expect { delete :destroy, id: gadget }.to change(Gadget, :count).by(-1)
      end

      it 'redirects to gadgets list' do
        delete :destroy, id: gadget.to_param
        expect(response).to redirect_to gadgets_url  
      end
    end
  end
  
  
  describe "GET search" do
    context 'user is not signed in' do
      it 'redirects to sign in page' do
        get :search, query: 'name'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    context 'user is signed in' do
      let(:user) { create(:user) }
      let(:gadget1) { create(:gadget, user: user, name: 'gadget1') }
      let(:gadget2) { create(:gadget, user: user, name: 'other gadget') }

      let(:other_gadget) { create(:gadget, user: user, name: 'some other') }

      before :each do
        sign_in user
      end

      it 'is successfull' do
        get :search, query: 'gadget'
        expect(response).to have_http_status(:success)
      end

      it 'renders index template' do
        get :search, query: 'gadget'
        expect(response).to render_template(:search)
      end

      it 'assings gadgets of the signed in user' do
        get :search, query: 'gadget'
        expect(assigns(:gadgets)).to include(gadget1, gadget2)
      end

      it 'does not assign other users gadgets' do
        get :search, query: 'gadget'
        expect(assigns(:gadgets)).to_not include(other_gadget)
      end
    end
    
  end
end
