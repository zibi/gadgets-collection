require 'rails_helper'

RSpec.describe Image, :type => :model do
  it "belongs to gadget" do
    expect(subject).to belong_to(:gadget)
  end 
end
