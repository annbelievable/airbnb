# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'


user = {}

ActiveRecord::Base.transaction do
  30.times do
    user['username'] = Faker::Name.first_name
    user['email'] = Faker::Internet.email
    user['phone_number'] = Faker::PhoneNumber.phone_number
    user['password'] = 'qwerty'
    User.create(user)
  end
end

listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  100.times do
    listing['name'] = Faker::Address.city
    listing['location'] = Faker::Address.street_address
    listing['description'] = ["House", "Entire Floor", "Condominium", "Villa", "Townhouse", "Castle", "Treehouse", "Igloo", "Yurt", "Cave", "Chalet", "Hut", "Tent", "Other"].sample
    listing['price'] = rand(80..500)
    listing['user_id'] = uids.sample
    Listing.create(listing)
  end
end
