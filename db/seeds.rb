# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# CSV.foreach('db/csv/sizes.csv', headers: true) do |row|
#   row['ancestry'] = nil if row['ancestry'] == "NULL"
#   Sizing.create(
#     ancestry:       row['ancestry'],
#     name:           row['name']
#   )
# end

# CSV.foreach('db/csv/categories.csv', headers: true) do |row|
#   row['ancestry'] = nil if row['ancestry'] == "NULL"
#   row['sizing_id'] = nil if row['sizing_id'] == 'NULL'
#   Category.create!(
#     ancestry:       row['ancestry'],
#     name:           row['name'],
#     sizing_id:      row['sizing_id']
#   )
# end

# # Usersテーブル：ダミー登録
# 100.times do |u|
#   user = User.new(
#     nickname: Faker::Name.name,
#     email: Faker::Internet.email,
#     password: "aaaaaaa",
#     phone_number: "080#{rand(10000000..99999999)}"
#   )
#   user.build_identification(
#     last_name: Faker::Name.last_name, 
#     first_name: Faker::Name.first_name,
#     last_name_kana: "タカシ",
#     first_name_kana: "サイトウ",
#     birthday: "1999-12-31"
#   )
#   user.build_address(
#     last_name: Faker::Name.last_name, 
#     first_name: Faker::Name.first_name,
#     last_name_kana: "タカシ",
#     first_name_kana: "サイトウ", 
#     zip_code: "#{rand(100..999)}-#{rand(1000..9999)}", 
#     prefecture_id: rand(1..47), 
#     city: "ヤーナム", 
#     street: "ヨセフカの診療所",
#     building: "2F", 
#     phone_number_sub: "08012345678"
#   )
#   user.save!
# end

# itemsテーブル：ダミー登録
# image_file_path = Dir.glob('/Users/miurashintaro/projects/freemarket_sample_59a/app/assets/images/item_image_sample/*')
# grandchild_category = Category.where("ancestry LIKE ?", "%/%").pluck(:id)
# brand_name = ["シャネル", "ルイヴィトン", "シュプリーム", "ナイキ", "NOブランド"]
# user_ids = User.ids
# 300.times do |i|
#   item = Item.new(
#     name: Faker::Games::Pokemon.name,
#     description: Faker::Creature::Animal.name,
#     category_id: grandchild_category.sample,
#     sizing_id: rand(2..11),
#     condition: rand(0..5),
#     price: rand(300..20000),
#     brand: brand_name.sample,
#   )
#   item.build_transact(
#     seller_id: user_ids.sample,
#     bearing: "seller_side",
#     delivery_method: rand(0..8),
#     prefecture_id: rand(1..47),
#     ship_days: rand(0..2)
#   )
#   rand(1..10).times do
#     item.images.build(
#       name: File.open(image_file_path.sample)
#     )
#   end
#   item.save!
# end

Item.all.each do |item|
  item.destroy
end

brand_name = ["シャネル", "ルイヴィトン", "シュプリーム", "ナイキ", "NOブランド"]
user_ids = User.ids
# cate_dirs = Dir.glob('/var/www/freemarket_sample_59a/mercari_img/*/')
items = Dir.glob('/var/www/freemarket_sample_59a/mercari_img/*/')

items.each do |item|
  CSV.foreach("#{item}info.csv", headers: true) do |row|
    category_id = row['category_id'].to_i
    price = row['price'].to_i
    name = row['name']
    description = row['description']
    # size_idsの作成
    sizing = Category.find(category_id).sizing
    if sizing
      sizing_ids = sizing.child_ids
    else
      sizing_ids = []
    end
    # imageのpathの取得
    imgs = Dir.glob("#{item}*.jpg")
    # itemの作成
    item = Item.new(
      name: name,
      description: description,
      category_id: category_id,
      sizing_id: sizing_ids.sample,
      condition: rand(0..5),
      price: price,
      brand: brand_name.sample,
    )
    item.build_transact(
      seller_id: user_ids.sample,
      bearing: "seller_side",
      delivery_method: rand(0..8),
      prefecture_id: rand(1..47),
      ship_days: rand(0..2)
    )
    imgs.each do |img_path|
      item.images.build(
        name: File.open(img_path)
      )
    end
    item.save
  end
end
