require 'rails_helper'

RSpec.describe ImagesController, :type => :controller do
  let(:user) { create(:user) }
  let(:gadget) { create(:gadget, user: user) }
  
  describe 'GET index' do
    context 'user is not signed in' do
      it 'redirects to sign in page' do
        get :index, gadget_id: gadget.to_param
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    context 'user is signed in' do
      let(:image1) { create(:image, gadget: gadget) }
      let(:image2) { create(:image, gadget: gadget) }
      let(:other_image) { create(:image) }
      
      before :each do
        sign_in user
      end

      it 'is successfull' do
        get :index, gadget_id: gadget.to_param
        expect(response).to have_http_status(:success)
      end

      it 'renders index template' do
        get :index, gadget_id: gadget.to_param
        expect(response).to render_template(:index)
      end
      
      
      it 'assigns images for the gadget' do
        get :index, gadget_id: gadget.to_param
        expect(assigns(:images)).to include(image1, image2)
      end

      it 'does not assigns images for other gadgets' do
        get :index, gadget_id: gadget.to_param
        expect(assigns(:images)).to_not include(other_image)
      end
    end
  end
  
  describe "GET show" do
    context 'user is not signed in' do
      it 'redirects to sign in page' do
        get :show, gadget_id: gadget.to_param, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      let(:image) { create(:image, gadget: gadget) }
      
      before :each do
        sign_in user
      end

      it 'is successfull' do
        get :show, gadget_id: gadget.to_param, id: image.to_param
        expect(response).to have_http_status(:success)
      end

      it 'renders show template' do
        get :show, gadget_id: gadget.to_param, id: image.to_param
        expect(response).to render_template(:show)
      end

      it 'assigns gadget' do
        get :show, gadget_id: gadget.to_param, id: image.to_param
        expect(assigns(:gadget)).to eq gadget
      end
    end
  end
  
  describe "GET edit" do
    context 'user is not signed in' do
      it 'redirects to sign in page' do
        get :show, gadget_id: gadget.to_param, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      before :each do
        sign_in user
      end

      let(:image) { create(:image, gadget: gadget) }

      it 'is successfull' do
        get :edit, gadget_id: gadget.to_param, id: image.to_param
        expect(response).to have_http_status(:success)
      end

      it 'renders edit template' do
        get :edit, gadget_id: gadget.to_param, id: image.to_param
        expect(response).to render_template(:edit)
      end

      it 'assigns gadget' do
        get :edit, gadget_id: gadget.to_param, id: image.to_param
        expect(assigns(:image)).to eq image
      end
    end
  end
  
  describe "GET new" do
    context 'user is not signed in' do
      it 'redirects to sign in page' do
        get :new, gadget_id: gadget.to_param
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      let(:user) { create(:user) }

      before :each do
        sign_in user
      end

      it 'is successfull' do
        get :new, gadget_id: gadget.to_param
        expect(response).to have_http_status(:success)
      end

      it 'renders new template' do
        get :new, gadget_id: gadget.to_param
        expect(response).to render_template(:new)
      end

      it 'assigns new instance of Gadget' do
        get :new, gadget_id: gadget.to_param
        expect(assigns(:image)).to be_a_new(Image)
      end
    end
  end
  
end
