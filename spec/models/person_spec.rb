require 'rails_helper'

RSpec.describe Person, type: :model do
  
	let(:person) do
		Person.new(first_name: 'Alice', last_name: 'Smith')
	end
	
	it 'is valid' do
		expect(person).to be_valid
	end
	
	it 'is invalid without a first name' do
		person.first_name = nil
		expect(person).to_not be_valid
	end
	
	it 'is invalid without a last name' do
		person.last_name = nil
		expect(person).to_not be_valid
	end
	
	it 'updates the requested person' do
		person = Person.create!(valid_attributes)
		put :update, { :id => person.to_param, :person => new_attributes }, valid_session
		person.reload
		expect(person.first_name).to eq('NewFirstName')
		expect(person.last_name).to eq('NewLastName')
	end
	
end
