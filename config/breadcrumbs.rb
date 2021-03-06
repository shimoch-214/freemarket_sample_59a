crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", mypage_path
  parent :root
end

crumb :notification do
  link "お知らせ", notification_mypage_path
  parent :mypage
end

crumb :todo do
  link "やることリスト", todo_mypage_path
  parent :mypage
end

crumb :parchase do
  link "購入した商品-取引中", parchase_mypage_path
  parent :mypage
end

crumb :parchased do
  link "購入した商品-過去の取引", parchased_mypage_path
  parent :mypage
end

crumb :listings do
  link "出品した商品-出品中", parchased_mypage_path
  parent :mypage
end

crumb :in_progress do
  link "出品した商品-取引中", parchased_mypage_path
  parent :mypage
end

crumb :completed do
  link "出品した商品-売却済み", parchased_mypage_path
  parent :mypage
end

crumb :profile do
  link "プロフィール", profile_mypage_path
  parent :mypage
end

crumb :identification do
  link "本人情報の登録", identification_mypage_path
  parent :mypage
end

crumb :logout do
  link "ログアウト"
  parent :mypage
end


crumb :card do
  link "支払い方法", cards_path
  parent :mypage
end

crumb :edit do
  link "クレジットカード情報入力"
  parent :card
end

crumb :categories do
  link "カテゴリー一覧", categories_path
  parent :root
end

crumb :category do |category|
  category=Category.find(params[:id])
  link category.name
  parent :categories
end
