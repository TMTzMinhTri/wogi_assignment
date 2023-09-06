# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.find_or_create_by(email: "admin@gmail.com") do |user|
  user.name = "Admin"
  user.role = 0
  user.password = "admin@123"
  user.password_confirmation = "admin@123"
end

User.find_or_create_by(email: "client@gmail.com") do |user|
  user.name = "Client"
  user.role = "client"
  user.password = "client@123"
  user.password_confirmation = "client@123"
end

products = {
  name: Faker::Coffee.blend_name,
  description: Faker::Coffee.notes,
  price: 1,
  brand_id: 2,
}
