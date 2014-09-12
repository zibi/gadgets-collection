require 'rails_helper'

RSpec.describe "gadgets/search.html.erb", :type => :view do
  let(:query) { 'search term' }

  context "there are some gadgets found" do
    let(:gadget1) { create(:gadget) }
    let(:gadget2) { create(:gadget) }
  
    before :each do
      assign(:query, query)
      assign(:gadgets, [gadget1, gadget2])
      render
    end

    it "displays all the gadgets" do
      assert_select('a[href=?]', gadget_path(gadget1))
      assert_select('a[href=?]', gadget_path(gadget2))
    end

    it 'displays link to show all gadgets' do
      assert_select('a[href=?]', gadgets_path)    
    end

    it 'displays the search term' do
      assert_select "h1" do |h1|
        expect(h1.to_s).to match /Search results for search term/
      end
    end
  end
  
  context "no gadget was found" do
    before :each do
      assign(:query, query)
      assign(:gadgets, [])
      render
    end
    
    it 'displays message' do
      expect(rendered).to match /no gadget found/
    end
  end
end
