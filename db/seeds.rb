# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
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
100.times do |u|
  user = User.new(
    nickname: Faker::Name.name,
    email: Faker::Internet.email,
    password: "aaaaaaa",
    phone_number: "080#{rand(10000000..99999999)}"
  )
  user.build_identification(
    last_name: Faker::Name.last_name, 
    first_name: Faker::Name.first_name,
    last_name_kana: "タカシ",
    first_name_kana: "サイトウ",
    birthday: "1999-12-31"
  )
  user.build_address(
    last_name: Faker::Name.last_name, 
    first_name: Faker::Name.first_name,
    last_name_kana: "タカシ",
    first_name_kana: "サイトウ", 
    zip_code: "#{rand(100..999)}-#{rand(1000..9999)}", 
    prefecture_id: rand(1..47), 
    city: "ヤーナム", 
    street: "ヨセフカの診療所",
    building: "2F", 
    phone_number_sub: "08012345678"
  )
  user.save!
end

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

brand_name = ["シャネル", "ルイヴィトン", "シュプリーム", "ナイキ", "NOブランド"]
user_ids = User.ids
cate_dirs = Dir.glob('/var/www/freemarket_sample_59a/mercari_img/*/')

cate_dirs.each do |cate_dir|
  category_id = cate_dir.split('_').last.gsub(/_/, '').to_i
  sizing = Category.find(category_id).sizing
  if sizing
    sizing_ids = sizing.child_ids
  else
    sizing_ids = []
  end

  img_dirs = Dir.glob("#{cate_dir}*/")
  img_dirs.each do |img_dir|
    item = Item.new(
      name: Faker::Games::Pokemon.name,
      description: Faker::Creature::Animal.name,
      category_id: category_id,
      sizing_id: sizing_ids.sample,
      condition: rand(0..5),
      price: rand(300..20000),
      brand: brand_name.sample,
    )
    item.build_transact(
      seller_id: user_ids.sample,
      bearing: "seller_side",
      delivery_method: rand(0..8),
      prefecture_id: rand(1..47),
      ship_days: rand(0..2)
    )
    Dir.glob("#{img_dir}*").each do |img_path|
      item.images.build(
        name: File.open(img_path)
      )
    end
    item.save
  end
end