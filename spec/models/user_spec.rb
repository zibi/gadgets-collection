require 'rails_helper'

RSpec.describe User, :type => :model do  
  it "validates presence of email" do
    expect(subject).to be_invalid
    expect(subject.errors[:email]).to_not be_empty
  end

  it 'validates uniqueness of email' do
    saved_user = create(:user, email: 'test@test.com')
    subject.email = 'test@test.com'
    expect(subject).to be_invalid    
    expect(subject.errors[:email].join).to match /taken/
  end
end
