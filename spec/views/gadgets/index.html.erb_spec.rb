require 'rails_helper'

RSpec.describe "gadgets/index.html.erb", :type => :view do
  let(:gadget1) { create(:gadget) }
  let(:gadget2) { create(:gadget) }
  
  before :each do
    assign(:gadgets, [gadget1, gadget2])
    render
  end

  it "displays all the gadgets" do
    assert_select('a[href=?]', gadget_path(gadget1))
    assert_select('a[href=?]', gadget_path(gadget2))
  end
  
  it 'display link for adding new gadgets' do
    assert_select('a[href=?]', new_gadget_path)    
  end
end
