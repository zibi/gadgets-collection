require 'rails_helper'

RSpec.describe "images/edit.html.erb", :type => :view do
  let(:gadget) { create(:gadget) }
  let(:image) { create(:image, gadget: gadget) }

  before :each do
    assign(:gadget, gadget)
    assign(:image, image)
    render
  end
  
  it 'provides field for editing gadget title' do
    assert_select 'input[type=?][name=?][value=?]', 'text', 'image[title]', image.title
  end

  it 'provides field for uploading new image file' do
    assert_select 'input[type=?][name=?]', 'file', 'image[content]'
  end

  it 'provides link to cancel editing' do
    assert_select 'a[href=?]', gadget_image_path(gadget, image)
  end
end
