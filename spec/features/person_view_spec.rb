require 'rails_helper'

describe 'the person view', type: :feature do
  
  let(:person) {
    Person.create(first_name: 'John', last_name: 'Doe')
  }
  
	describe 'phone numbers' do
	
		before(:each) do
			person.phone_numbers.create(number: "555-1234")
			person.phone_numbers.create(number: "555-5678")
			visit person_path(person)
		end

		it 'shows the phone numbers' do
			person.phone_numbers.each do |phone|
				expect(page).to have_content(phone.number)
			end
		end
		
		it 'has a link to a new phone number' do
			expect(page).to have_link('Add phone number', href: new_phone_number_path)
		end
		
		it 'adds a new phone number' do
			page.click_link('Add phone number')
			page.fill_in('Number', with: '555-8888')
			page.click_button('Create Phone number')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('555-8888')
		end
		
		it 'has a link to add a new phone number' do
			expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
		end
		
		it 'has links to edit phone numbers' do
			person.phone_numbers.each do |phone|
				expect(page).to have_link('edit', href: edit_phone_number_path(phone))
			end
		end
		
		it 'edits a phone number' do
			phone = person.phone_numbers.first
			old_number = phone.number
			
			first(:link, 'edit').click
			page.fill_in('Number', with: '555-9191')
			page.click_button('Update Phone number')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('555-9191')
			expect(page).to_not have_content(old_number)
		end
  end
	
	describe 'Email Addresses' do
		before(:each) do
			person.email_addresses.create(address: "example@example.com")
			person.email_addresses.create(address: "example@example.com")
			visit person_path(person)
		end
		
		it 'should have lists' do
			expect(page).to have_selector('li', text: 'example@examples.com')
		end
		
		it 'has a link to add a new email address' do
			expect(page).to have_link('Add Email Address', href: new_email_address_path(person_id: person.id))
		end
		
		it 'adds a new email address do'
			page.click_link('Add Email Address')
			page.fill_in('Address', with: 'example@example.com')
			page.fill_in('Person Id', with: person.id)
			page.click_button('Submit')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('example@example.com')
		end
		
	end
	
end
