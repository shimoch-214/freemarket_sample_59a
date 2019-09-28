# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# CSV.foreach('db/csv/categories.csv', headers: true) do |row|
#   row['ancestry'] = nil if row['ancestry'] == "NULL"
#   Category.create!(
#     ancestry: row['ancestry'],
#     name: row['name']
#   )
# end

# CSV.foreach('db/csv/sizes.csv', headers: true) do |row|
#   row['ancestry'] = nil if row['ancestry'] == "NULL"
#   Sizing.create(
#     ancestry: row['ancestry'],
#     name: row['name']
#   )
# end

# category_roots = Category.roots
# レディース
# ladies = category_roots[0]
# ladies.children[0].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# ladies.children[1].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# ladies.children[2].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# ladies.children[3].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# ladies.children[4].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# ladies.children[5].children.each do |gc|
#   gc.update(sizing_id: 29)
# end
# ladies.children[6].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# ladies.children[15].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# ladies.children[16].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# ladies.children[17].children.each do |gc|
#   gc.update(sizing_id: 1)
# end

# メンズ
# mens = category_roots[1]
# mens.children[0].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# mens.children[1].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# mens.children[2].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# mens.children[3].children.each do |gc|
#   gc.update(sizing_id: 12)
# end
# mens.children[5].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# mens.children[10].children.each do |gc|
#   gc.update(sizing_id: 1)
# end
# mens.children[12].children.each do |gc|
#   gc.update(sizing_id: 1)
# end

# ベビー・キッズ
# baby_kids = category_roots[2]
# baby_kids.children[0].children.each do |gc|
#   gc.update(sizing_id: 69)
# end
# baby_kids.children[1].children.each do |gc|
#   gc.update(sizing_id: 69)
# end
# baby_kids.children[2].children.each do |gc|
#   gc.update(sizing_id: 69)
# end
# baby_kids.children[3].children.each do |gc|
#   gc.update(sizing_id: 52)
# end
# baby_kids.children[4].children.each do |gc|
#   gc.update(sizing_id: 52)
# end
# baby_kids.children[5].children.each do |gc|
#   gc.update(sizing_id: 52)
# end
# baby_kids.children[6].children.each do |gc|
#   gc.update(sizing_id: 60)
# end

# 家電・スマホ・カメラ
# gadget = category_roots[7]
# gadget.children[3].children[2].update(sizing_id: 86)
# gadget.children[3].children[3].update(sizing_id: 86)
# gadget.children[4].children[0].update(sizing_id: 75)

# スポーツ・レジャー
# sports = category_roots[8]
# sports.children[7].children[0].update(sizing_id: 137)
# sports.children[7].children[2].update(sizing_id: 12)
# sports.children[7].children[3].update(sizing_id: 29)
# sports.children[7].children[4].update(sizing_id: 60)
# sports.children[7].children[5].update(sizing_id: 1)
# sports.children[7].children[6].update(sizing_id: 1)
# sports.children[7].children[7].update(sizing_id: 52)
# sports.children[8].children[0].update(sizing_id: 129)
# sports.children[8].children[1].update(sizing_id: 12)
# sports.children[8].children[2].update(sizing_id: 29)
# sports.children[8].children[3].update(sizing_id: 60)
# sports.children[8].children[5].update(sizing_id: 1)
# sports.children[8].children[6].update(sizing_id: 1)
# sports.children[8].children[7].update(sizing_id: 52)

# 自動車・オートバイ
# vehicle = category_roots[11]
# vehicle.children[1].children.each do |gc|
#   gc.update(sizing_id: 115)
# end
# vehicle.children[6].children[0].update(sizing_id: 106)

# Category.where(name: "その他").update_all(sizing_id: nil)


# Usersテーブル：ダミー登録
3.times do |u|
  User.create!(
    email: Faker::Internet.email,
    password: "asdfghjk"
  )
end

# itemsテーブル：ダミー登録
item_num = 300
item_num.times do |i|
  item = Item.new(
    price: rand(100..99999),
    name: Faker::Name.name ,
    category_id: rand(3..20),
    sizing_id: rand(2..11),
    description: Faker::Creature::Animal.name,
    condition: rand(0..5),
  )
  item.build_transact(
    seller_id: 1,
    delivery_method: rand(0..8),
    bearing: false,
    ship_days: rand(0..2),
    status: rand(0..5),
    prefecture_id: rand(1..47)
  )
  if item.transact.status.to_i > 0
    item.transact.buyer = User.find(2)
  end

  # item.transact.save!
  binding.pry
  item.save!

  10.times do |img|
    Image.create!(
      name: "sample_image_gandam.jpg",
      item_id: img
    )
  end
end

# transactsテーブル：ダミー登録
# item_num.times do |t|
#   Transact.create!(
#     item_id: t,
#     seller_id: 1,
#     delivery_method: rand(0..8),
#     bearing: false,
#     ship_days: rand(0..2),
#     status: rand(0..5),
#     prefecture_id: rand(1..47)
#   )
# end