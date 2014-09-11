require 'rails_helper'

RSpec.describe "gadgets/show.html.erb", :type => :view do
  let(:gadget) { create(:gadget) }
  
  before :each do
    assign(:gadget, gadget)
    render
  end
  
  it 'displays gadget name' do
    expect(rendered).to match gadget.name
  end
  
  it 'displays gadget description' do
    expect(rendered).to match gadget.description    
  end
  
  it 'displays link for editing the gadget' do
    assert_select 'a[href=?]', edit_gadget_path(gadget)
  end

  it 'displays link for destroying the gadget' do
    assert_select 'a[data-method=?][href=?]', "delete", gadget_path(gadget)
  end
  
  it 'displays link to get back to gadgets list' do
    assert_select 'a[href=?]', gadgets_path
  end
end