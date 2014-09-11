require 'rails_helper'

RSpec.describe Gadget, :type => :model do
  it 'validates presence of name' do
    expect(subject).to validate_presence_of(:name)
  end
  
  it 'validates uniqueness of name' do
    expect(subject).to validate_uniqueness_of(:name)
  end
  
  it 'belongs to user' do
    expect(subject).to belong_to(:user)
  end
  
  it 'has many images' do
    expect(subject).to have_many(:images)
  end
end
