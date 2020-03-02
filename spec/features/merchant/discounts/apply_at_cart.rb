require 'rails_helper'

RSpec.describe 'As a USER' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @merchant_2 = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword', role: 1)
    @ogre = @merchant_1.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 50)

    @discount_1 = @merchant_1.discounts.create!(
      name: 'Small Discount',
      item_threshold: 20,
      percentage_off: 5
    )

    @discount_2 = @merchant_1.discounts.create!(
      name: 'Big Discount',
      item_threshold: 40,
      percentage_off: 10
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
  end

  it 'can apply the small discount to an item' do
    visit item_path(@ogre)
    click_button 'Add to Cart'

    visit '/cart'

    18.times do
      click_on 'More of This!'
    end

    within "#item-#{@ogre.id}" do
      expect(page).to have_content('Subtotal: $384.75')
    end

    click_on 'More of This!'

    within "#item-#{@ogre.id}" do
      expect(page).to have_content('Quantity: 20')
      expect(page).to have_content('Subtotal: $384.75 (Discount of 5% applied!)')
    end
  end
end
