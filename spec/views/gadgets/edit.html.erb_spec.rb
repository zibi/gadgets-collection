require 'rails_helper'

RSpec.describe "gadgets/edit.html.erb", :type => :view do
  let(:gadget) { create(:gadget) }

  before :each do
    assign(:gadget, gadget)
    render
  end
  
  it 'provides field for editing gadget name' do
    assert_select 'input[type=?][name=?][value=?]', 'text', 'gadget[name]', gadget.name
  end

  it 'provides field for editing gadget description' do
    assert_select 'textarea[name=?]', 'gadget[description]'
  end
  
  it 'provides link to cancel editing' do
    assert_select 'a[href=?]', gadget_path(gadget)
  end
end
