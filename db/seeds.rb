require 'faker'
require "csv"

User.destroy_all
Province.destroy_all
Shoe.destroy_all
Order.destroy_all
OrderItem.destroy_all
SalePrice.destroy_all
Brand.destroy_all

AdminUser.destroy_all

filename = Rails.root.join("db/Shoe prices.csv")
puts "Loading Shoes from the CSV file: #{filename}"

csv_data = File.read(filename)
shoes = CSV.parse(csv_data, headers: true, encoding: "UTF-8")

shoes.each do |s|
  brand = Brand.find_or_create_by(brand_name: s["brand_name"])
  sale_price = SalePrice.find_or_create_by(sale_price: s["sale_price"])

  if brand && brand.valid?
    shoe = Shoe.create(
      shoe_model:         s["shoe_model"],
      brand:              brand,
      shoe_type:          s["shoe_type"],
      size:               s["size"],
      color:              s["color"],
      material:           s["material"],
      gender:             s["gender"],
      price:              s["price"],
      sale_price:         sale_price,
      quantity_available: Faker::Number.between(from: 0, to: 50),
      description:        Faker::Lorem.paragraph(sentence_count: 5, random_sentences_to_add: 6)
    )

    if shoe.valid?
      puts "Product #{s['brand_name']} created successfully."
    else
      puts "Invalid product #{s['brand_name']}: #{shoe.errors.full_messages.join(', ')}"
    end
  else
    puts "Invalid product #{s['brand_name']}: #{brand.errors.full_messages.join(', ')}"
  end
end

puts "Created #{Brand.count} Brand"

Province.create!([{
                  name: "Alberta",
                  GST: 0.05
                },
                {
                  name: "British Columbia",
                  GST: 0.05,
                  PST: 0.07
                },
                {
                  name: "Manitoba",
                  GST: 0.05,
                  PST: 0.07
                },
                {
                  name: "New Brunswick",
                  HST: 0.15
                },
                {
                  name: "Newfoundland and Labrador",
                  HST: 0.15
                },
                {
                  name: "Northwest Territories",
                  GST: 0.05
                },
                {
                  name: "Nova Scotia",
                  HST: 0.15
                },
                {
                  name: "Nunavut",
                  GST: 0.05
                },
                {
                  name: "Ontario",
                  HST: 0.13
                },
                {
                  name: "Prince Edward Island",
                  HST: 0.15
                },
                {
                  name: "Quebec",
                  GST: 0.05
                },
                {
                  name: "Saskatchewan",
                  GST: 0.05,
                  PST: 0.06
                }])
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?