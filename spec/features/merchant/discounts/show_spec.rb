require 'rails_helper'

RSpec.describe 'As a merchant employee' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @merchant_2 = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword', role: 1)
    @ogre = @merchant_1.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)

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

  describe "When I try to see a specific discount" do
    it 'can click an edit button next to each discount' do
      visit "merchant/discounts/#{@discount_1.id}"

      expect(page).to have_content(@discount_1.name)
      expect(page).to have_content(@discount_1.item_threshold)
      expect(page).to have_content(@discount_1.percentage_off)
    end
  end
end
