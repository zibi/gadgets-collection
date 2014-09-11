require 'rails_helper'

RSpec.describe User, :type => :model do  
  it "validates presence of email" do
    expect(subject).to validate_presence_of(:email)
  end

  it 'validates uniqueness of email' do
    expect(subject).to validate_uniqueness_of(:email)
  end
  
  it 'has many gadgets' do
    expect(subject).to have_many(:gadgets)
  end
end
