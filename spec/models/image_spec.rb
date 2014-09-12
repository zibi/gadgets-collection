require 'rails_helper'

RSpec.describe Image, :type => :model do
  it "belongs to gadget" do
    expect(subject).to belong_to(:gadget)
  end 
  
  it 'has a content file' do
    expect(subject).to have_attached_file(:content)
  end
  
  it 'validates presence of content file' do
    expect(subject).to validate_attachment_presence(:content)
  end
end
