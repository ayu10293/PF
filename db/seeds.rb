# 管理者
admins = [
  {email: "555@555", password: "555555"}
]

admins.each do |admin|
  # ref: https://railsdoc.com/page/find_or_create_by
  Admin.find_or_create_by(email: admin[:email]) do |a|
    a.password = admin[:password]
  end
end

# カスタマー
customers = [
  {name: "うさぎ", email: "111@111", password: "111111"},
  {name: "らいおん", email: "222@222", password: "222222"},
]

customers.each do |customer|
  # ref: https://railsdoc.com/page/find_or_create_by
  Customer.find_or_create_by(email: customer[:email]) do |c|
    c.name = customer[:name]
    c.password = customer[:password]
  end
end

# レシピ
# EOSとは: https://qiita.com/zakuroishikuro/items/208549a859c25e3896c1
recipes = [
  # レシピ1
  {
    customer_email: "111@111",
    title: "肉野菜炒め",
    images: ["yasai.png", "curry.png"],
    body:<<EOS,
にんじんは皮をむきます。ピーマンはヘタと種を取り除きます。
1．にんじんは短冊切りにします。
2.キャベツは1口大に切ります。ピーマンは1センチ幅に切ります。
3.ボウルに料理酒、しょうゆ、オイスターソース、鶏がらスープの素を入れて混ぜ合わせます。
4.豚小間切れ肉に薄力粉をまぶします。
5.中火で熱したフライパンにサラダ油をひき、4を入れて炒めます。色が変わったら塩コショウを振り、さっと炒めて一度取り出します。
6.同じフライパンを強火で熱し、1を入れて炒めます。
7.にんじんに火が通ったら2ともやしを入れて強火で炒めます。
8.キャベツがしんなりとしたら5と3を入れて強火のまま炒めます。
9.全体に味がなじんだら火からおろし、器に盛りつけて完成です。
EOS
    recipe_ingredients: [
      {name: "豚小間切れ肉", quantity: "150g"},
      {name: "薄力粉", quantity: "小さじ1"},
      {name: "塩こしょう", quantity: "ひとつまみ"},
      {name: "にんじん", quantity: "1/3本"},
      {name: "キャベツ", quantity: "200ｇ"},
      {name: "もやし", quantity: "100ｇ"},
      {name: "ピーマン", quantity: "2個"},
      {name: "料理酒", quantity: "大さじ1"},
      {name: "しょうゆ", quantity: "大さじ1/2"},
      {name: "オイスターソース", quantity: "大さじ1/2"},
      {name: "鶏がらスープの素", quantity: "小さじ1"},
      {name: "サラダ油", quantity: "大さじ1/2"},
    ]
  },
  # レシピ2
  {
    customer_email: "222@222",
    title: "ツナカレー(3皿分)",
    images: ["curry.png", "yasai.png"],
    body:<<EOS,

EOS
    recipe_ingredients: [
      {name: "カレー粉", quantity: "6片"},
      {name: "ツナ缶", quantity: "2缶"},
    ]
  },
]

recipes.each do |recipe|
  customer = Customer.find_by(email: recipe[:customer_email]) # 投稿ユーザー

  # レシピ
  Recipe.find_or_create_by(customer_id: customer.id, title: recipe[:title]) do |r|
    r.body = recipe[:body] # 本文

    # 画像(配列の順通り登録)
    recipe[:images].each do |image|
      r.images.attach(io: File.open(Rails.root.join("db/images/#{image}")), filename: "#{image}")
    end

    # 材料レコード
    # アソシエーションで繋がった材料を必要数buildする
    recipe[:recipe_ingredients].each do |recipe_ingredient|
      r.recipe_ingredients.build(
        name: recipe_ingredient[:name],
        quantity: recipe_ingredient[:quantity]
      )
    end
  end
end
