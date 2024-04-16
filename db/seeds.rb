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
                  region_name: "Alberta",
                  gst: 0.05
                },
                {
                  region_name: "British Columbia",
                  gst: 0.05,
                  pst: 0.07
                },
                {
                  region_name: "Manitoba",
                  gst: 0.05,
                  pst: 0.07
                },
                {
                  region_name: "New Brunswick",
                  hst: 0.15
                },
                {
                  region_name: "Newfoundland and Labrador",
                  hst: 0.15
                },
                {
                  region_name: "Northwest Territories",
                  gst: 0.05
                },
                {
                  region_name: "Nova Scotia",
                  hst: 0.15
                },
                {
                  region_name: "Nunavut",
                  gst: 0.05
                },
                {
                  region_name: "Ontario",
                  hst: 0.13
                },
                {
                  region_name: "Prince Edward Island",
                  hst: 0.15
                },
                {
                  region_name: "Quebec",
                  gst: 0.05
                },
                {
                  region_name: "Saskatchewan",
                  gst: 0.05,
                  pst: 0.06
                }])
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?