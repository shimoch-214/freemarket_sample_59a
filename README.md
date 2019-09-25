# README

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|price|integer|null: false, index: true|
|name|string|null: false, index: true|
|user|references|null: false, foreign_key: true|
|category|references|null: false, foreign_key:true|
|bland|references|foreign_key: true|
|size|references|foreign_key: true|
|description|text|default: "商品の説明はありません"|
|condition|integer|null: false, index: true|
### Association
- belongs_to :user
- belongs_to :payment
- belongs_to :brand
- has_one :transactions
- has_many :comments
- has_many :likes
- has_many :images
- has_many :messages
- has_many :categories
- has_many :blands
- has_many :sizes
- has_many :comments 
- has_many :messages
- has_many :likes
- has_many :images


## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false, index: true, unique: true|
|phone_number|string|null: false|
|avator_image|string| |
|password|string| |
|password_confirmation|string| |
|profile|text| |
|card_id|integer| |
|nickname|string|null: false|
### Association
- has_one :credit_cards
- has_many :items
- has_one :addresses
- has-one :identifications
- has_many :transactions 
- has_many :ratings
- has_many :comments 
- has_many :likes


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|zip_code|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|street|string|null: false|
|building|string| |
|phone_number_sub|string| |
### Association
- belongs_to :user


## identificationsテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|zip_code|string| |
|prefecture|string| |
|city|string| |
|street|string| |
|building|string| |
|birth_year|string|null: false|
|birth_month|string|null: false|
|birth_day|string|null: false|
### Association
belongs_to :user

## transactionsテーブル
|Column|Type|Options|
|------|----|-------|
|item|references|null: false, foreign_key: true|
|seller|references|null: false, foreign_key: true|
|buyer|references|foreign_key: true|
|delivery_method|integer|null: false|
|bearing|boolean|null: false|
|ship_days|integer|null: false|
|payment|references|null: false|
|status|integer| |
|parchased_at|date| |
### Association
- belongs_to :item
- belongs_to :user
- has_many :payments


## paymentsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
### Association
- belongs_to :transaction
- has_many :items


## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user


## ratingsテーブル
|Column|Type|Options|
|------|----|-------|
|from|references|null: false, foreign_key: true|
|to|references|null: false, foreign_key: true|
|message|references| |
|rate|integer|null: false|
|position|boolean|null: false|
### Association
- belongs_to :user


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|item|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item


## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|item|references|null: false, foreign_key: true|
### Association
- belongs_to :item


## likesテーブル
|Column|Type|Options|
|------|----|-------|
|item|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|item|references|null: false, foreign_key: true|
### Association
- belongs_to :item


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|ancestry|string| |
|size|references|foreign_key: true|
|name|string|null: false|
### Association
- has_many :items
- belongs_to :size


## sizesテーブル
|Column|Type|Options|
|------|----|-------|
|ancestry|string| |
|name|string|null: false|
### Association
- has_many :items
- has_many :categories 


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

sasa