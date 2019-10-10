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
