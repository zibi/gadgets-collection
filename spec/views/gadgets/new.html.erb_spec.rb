require 'rails_helper'

RSpec.describe "gadgets/new.html.erb", :type => :view do
  before :each do
    assign(:gadget, Gadget.new)
    render
  end
  
  it 'provides field for gadget name' do
    assert_select 'input[type=?][name=?]', 'text', 'gadget[name]'
  end

  it 'provides field for gadget description' do
    assert_select 'textarea[name=?]', 'gadget[description]'
  end
  
  it 'provides link to cancel editing and get back to list' do
    assert_select 'a[href=?]', gadgets_path
  end
end