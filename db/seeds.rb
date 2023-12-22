require 'faker'

users = 5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "12345678",
    role: 'host'
  )
end

User.all.each do |user|
  2.times do
    spa = Spa.create!(
      name: Faker::Company.name,
      address: Faker::Address.street_address,
      price: Faker::Number.decimal(l_digits: 2),
      rating: rand(1..5),
      user: user
    )
    2.times do
      image_url = "https://source.unsplash.com/random/900x700/?zen,sauna"
      image_io = URI.open(image_url)
      spa.images.attach(io: image_io, filename: "image.jpg")
    end
  end
end
