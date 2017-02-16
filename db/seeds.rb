# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# create the first ancient category
name = "Clothes, Shoes"
current_id = 1
description = Faker::Lorem.sentence(5)
Category.create!(name: name, parent_id: 0, description: description)
#child = 2 + Random.rand(5)
child = 2
child.times do |n|
  name = Faker::Name.name
  description = Faker::HarryPotter.quote
  cate = Category.create!(name: name, parent_id: current_id,
    description: description)
  #child_child = Faker::Number.between(3, 5)
  child_child = 2
  child_child.times do |m|
    name = Faker::Name.name
    description = Faker::HarryPotter.quote
    cate_child = Category.create!(name: name, parent_id: cate.id,
      description: description)
    product_num = Faker::Number.between(10,13)
    product_num.times do |x|
      name = Faker::Name.name
      price = Faker::Commerce.price
      description = Faker::Lorem.sentence(20)
      tmp = Random.rand(10)
      if tmp < 2
        hot = true
      else
        hot = false
      end
      Product.create!(name: name, price: price, description: description,
        is_hot: hot, category_id: cate_child.id)
    end
  end
end

