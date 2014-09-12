require 'rails_helper'

RSpec.describe "images/show.html.erb", :type => :view do
  let(:gadget) { create(:gadget) }
  let(:image) { create(:image, gadget: gadget) }
  
  before :each do
    assign(:gadget, gadget)
    assign(:image, image)
    render
  end

  it "displays full image" do
    assert_select 'img[src=?]', image.content.url
  end
  
  it 'displays link for editing the image' do
    assert_select 'a[href=?]', edit_gadget_image_path(gadget, image)
  end

  it 'displays link for destroying the image' do
    assert_select 'a[data-method=?][href=?]', "delete", gadget_image_path(gadget, image)
  end
  
  it 'displays link to get back to images list' do
    assert_select 'a[href=?]', gadget_images_path(gadget)
  end
  
end