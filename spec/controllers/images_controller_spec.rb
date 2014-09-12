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

  describe "POST create" do
    context 'user is not signed in' do
      it 'redirects to sign in page' do
        post :create, gadget_id: gadget.to_param, image: attributes_for(:image)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      before :each do
        sign_in user
      end

      context "with valid parameters for Image" do
        it 'creates new instance of Image' do
          expect { post :create, gadget_id: gadget.to_param, 
            image: { content: fixture_file_upload('spec/test.jpg', 'image/jpeg')} }.to change(Image, :count).by(1)
        end

        it 'add the image to gadget images' do
          post :create, gadget_id: gadget.to_param, image: { content: fixture_file_upload('spec/test.jpg', 'image/jpeg')}
          gadget.reload
          expect(Image.last.gadget).to eq gadget
        end

        it 'redirects to show page for created image' do
          post :create, gadget_id: gadget.to_param, image: { content: fixture_file_upload('spec/test.jpg', 'image/jpeg')}
          expect(response).to redirect_to [gadget, Image.last]
        end
      end

      context "with invalid parameters for Image" do
        it 'does not create new instance of Image' do
          expect { post :create, gadget_id: gadget.to_param, image: { content: nil} }.to_not change(Image, :count)
        end

        it 'renders new template' do
          post :create, gadget_id: gadget.to_param, image: { content: nil }
          expect(response).to render_template(:new)
        end
      end
    end
  end
  
  describe "PUT update" do

    context 'user is not signed in' do
      it 'redirects to sign in page' do
        put :update, gadget_id: gadget.to_param, id: 1, image: { content: fixture_file_upload('spec/test.jpg', 'image/jpeg')}
        expect(response).to redirect_to(new_user_session_path)
      end
    end


    context 'user is signed in' do
      let(:image) { create(:image, gadget: gadget)}

      before :each do
        sign_in user
      end

      it 'assigns gadget' do
        put :update, gadget_id: gadget.to_param, id: image.to_param, image: { content: fixture_file_upload('spec/test.jpg', 'image/jpeg')}
        expect(assigns(:image)).to eq image
      end

      context "with valid params" do
        it 'redirects to show page' do
          put :update, gadget_id: gadget.to_param, id: image.to_param, image: { content: fixture_file_upload('spec/test.jpg', 'image/jpeg')}
          expect(response).to redirect_to [gadget, image]
        end

        it 'updates the gadget' do
          put :update, gadget_id: gadget.to_param, id: image.to_param, image: { content: fixture_file_upload('spec/test.jpg', 'image/jpeg')}
          image.reload
          expect(image.content_file_size).to eq 2568
        end
      end

      context "with invalid params" do
        it 'renders edit page' do
          put :update, gadget_id: gadget.to_param, id: image.to_param, image: { content: nil}
          expect(response).to render_template :edit
        end
      end
    end
  end
end
