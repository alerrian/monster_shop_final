Merchant.destroy_all
Discount.destroy_all
Item.destroy_all
User.destroy_all
Order.destroy_all

megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

# user information
@merchant_1 = megan.users.create!(name: "Meg", address: "123 merchant ave.", city: "City of Townsville", state: "Nv", zip: "39433", email: "merchant1@gmail.com", password: "merchant1", role: 1)
@merchant_2 = brian.users.create!(name: "Meg", address: "123 merchant ave.", city: "City of Townsville", state: "Nv", zip: "39433", email: "merchant2@gmail.com", password: "merchant2", role: 1)
@user = User.create!(name: 'person', address: '123 W', city: 'a', state: 'IN', zip: 12345, email: 'user@gmail.com', password: 'user', role: 0)
@admin = User.create(name: 'Kevin', address: '123 Street Road', city: 'City Name', state: 'CO', zip: 12345, email: 'admin@gmail.com', password: 'admin', role: 2)
