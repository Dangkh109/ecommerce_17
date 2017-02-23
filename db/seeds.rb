User.create! name: "tracthinh", email: "tracthinh@gmail.com",
  phone: "0123456789", address: "123 KeangNam", avatar: nil,
  password: "123456", password_confirmation: "123456", role: 0
User.create! name: "kieudang", email: "kieudang@gmail.com",
  phone: "9876543210", address: "123 KeangNam", avatar: nil,
  password: "123456", password_confirmation: "123456", role: 0
User.create! name: "user", email: "user@gmail.com",
  phone: "9876543210", address: "123 KeangNam", avatar: nil,
  password: "123456", password_confirmation: "123456", role: 1
100.times{
  name = Faker::Name.name
  email = Faker::Internet.email
  phone = Faker::PhoneNumber.phone_number
  address = Faker::Address.street_address
  password = "123456"
  user = User.create! name: name, email: email, phone: phone, address: address,
    password: password, password_confirmation: password, avatar: nil
  Order.create! status: 1, total_price: "10", user_id: user.id
}



big_cate = ["Clothes, Shoes", "Computer", "TV", "Personal stuff"]
big_cate.each do |stuff,index|
  name = stuff
  description = Faker::Lorem.sentence(5)
  code_dad = "00"+index.to_s
  dad = Category.create!(name: name, parent_id: 0, description: description, code: code_dad)
  #child = 2 + Random.rand(5)
  child = 2
  child.times do |n|
    name = Faker::Name.name
    code = code_dad+Faker::Number.number(3)
    description = Faker::HarryPotter.quote
    cate = Category.create!(name: name, parent_id: dad.id,
      description: description, code: code)
    #child_child = Faker::Number.between(3, 5)
    child_child = 2
    child_child.times do |m|
      child_code = code+ Faker::Number.number(3)
      name = Faker::Name.name
      description = Faker::HarryPotter.quote
      cate_child = Category.create!(name: name, parent_id: cate.id,
        description: description, code: child_code)
      product_num = Faker::Number.between(10,13)
      product_num.times do |x|
        name = Faker::Name.name
        price = Faker::Commerce.price
        description = Faker::Lorem.sentence(20)
        quantity = Faker::Number.between(0,13)
        img = nil
        tmp = Random.rand(10)
        if tmp < 2
          hot = true
        else
          hot = false
        end
        tmp = cate_child.products.create!(name: name, price: price,
          description: description, is_hot: hot, category_id: cate_child.id, in_stock: quantity)
      end
    end
  end
end
