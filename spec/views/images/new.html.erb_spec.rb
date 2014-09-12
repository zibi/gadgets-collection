require 'rails_helper'

RSpec.describe "images/new.html.erb", :type => :view do
  let(:gadget) { create(:gadget) }
  
  before :each do
    assign(:gadget, gadget)
    assign(:image, Image.new)
    render
  end
  
  it 'provides field for image title' do
    assert_select 'input[type=?][name=?]', 'text', 'image[title]'
  end

  it 'provides field for image file' do
    assert_select 'input[type=?][name=?]', 'file', 'image[content]'
  end
  
  it 'provides link to cancel editing and get back to list' do
    assert_select 'a[href=?]', gadget_images_path(gadget)
  end
end