# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

CSV.foreach('db/csv/sizes.csv', headers: true) do |row|
  row['ancestry'] = nil if row['ancestry'] == "NULL"
  Sizing.create(
    ancestry:       row['ancestry'],
    name:           row['name']
  )
end

CSV.foreach('db/csv/categories.csv', headers: true) do |row|
  row['ancestry'] = nil if row['ancestry'] == "NULL"
  row['sizing_id'] = nil if row['sizing_id'] == 'NULL'
  Category.create!(
    ancestry:       row['ancestry'],
    name:           row['name'],
    sizing_id:      row['sizing_id']
  )
end

# # Usersテーブル：ダミー登録
# 10.times do |u|
#   User.create!(
#     email: Faker::Internet.email,
#     password: "asdfghjk"
#   )
# end

# itemsテーブル：ダミー登録
# image_file_path = Dir.glob('/Users/miurashintaro/projects/freemarket_sample_59a/app/assets/images/item_image_sample/*')
# grandchild_category = Category.where("ancestry LIKE ?", "%/%").pluck(:id)
# brand_name = ["シャネル", "ルイヴィトン", "シュプリーム", "ナイキ", "NOブランド"]
# item_num = 300
# item_num.times do |i|
#   # sizing_num = Category.find(grandchild_category).sizing_id
#   item = Item.create!(
#     price: rand(100..99999),
#     name: Faker::Games::Pokemon.name,
#     category_id: grandchild_category.sample,
#     sizing_id: rand(2..11),
#     brand: brand_name.sample,
#     description: Faker::Creature::Animal.name,
#     condition: rand(0..5)
#   )
#   item.create_transact!(
#     seller_id: 1,
#     delivery_method: rand(0..8),
#     bearing: true,
#     ship_days: rand(0..2),
#     status: rand(0..5),
#     prefecture_id: rand(1..47)
#   )
#   item.create_image!(
#     name: 100,
#   )
#   if item.transact.status.to_i > 0
#     item.transact.buyer = User.find(2)
#   end

#   10.times do |img|
#     image = Image.create!(
#       name: File.open(image_file_path.sample),
#       item_id: Item.last.id
#       )
#   end
# end