require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
  let(:email_address) {
    EmailAddress.new(address: 'example@example.com')
  }
  
  it 'is valid' do
    expect(email).to be_valid
  end
  
  it 'is invalid without an email address' do
    email_address.address = nil
    expect(email_address).to_not be_valid
  end
	
	it 'is invalid without a person id' do
		email_address.person_id = nil
		expect(email_address).to_not be_valid
	end
    
end
