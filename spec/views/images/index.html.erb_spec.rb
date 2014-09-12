require 'rails_helper'

RSpec.describe "images/index.html.erb", :type => :view do
  let(:gadget) { create(:gadget) }
  let(:image1) { create(:image, gadget: gadget) }
  let(:image2) { create(:image, gadget: gadget) }
  
  before :each do
    assign(:gadget, gadget)
    assign(:images, [image1, image2])
    render
  end

  it "displays all the images thumbnails" do
    assert_select('a[href=?]', gadget_image_path(gadget, image1)) do
      assert_select('img[src=?]', image1.content.url(:thumb))
    end
    assert_select('a[href=?]', gadget_image_path(gadget, image2)) do
      assert_select('img[src=?]', image2.content.url(:thumb))
    end
  end
  
  
  it 'display link for adding new images' do
    assert_select('a[href=?]', new_gadget_image_path(gadget))
  end
end
