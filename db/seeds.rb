Admin.create!(
             email: "555@555",
             password: "555555"
             )

Customer.create!(
    name: "うさぎ",
    email: "uuu@uuu",
    password: "111111"
    )
Customer.create!(
    name: "らいおん",
    email: "uuu@444",
    password: "444444"
    )

recipe = Recipe.create!(
    title: "野菜炒め",
    body: "にんじんは皮をむきます。ピーマンはヘタと種を取り除きます。
    1．にんじんは短冊切りにします。
    2.キャベツは1口大に切ります。ピーマンは1センチ幅に切ります。
    3.ボウルに料理酒、しょうゆ、オイスターソース、鶏がらスープの素を入れて混ぜ合わせます。
    4.豚小間切れ肉に薄力粉をまぶします。
    5.中火で熱したフライパンにサラダ油をひき、4を入れて炒めます。色が変わったら塩コショウを振り、さっと炒めて一度取り出します。。
    6.同じフライパンを強火で熱し、1を入れて炒めます。
    7.にんじんに火が通ったら2ともやしを入れて強火で炒めます。
    8.キャベツがしんなりとしたら5と3を入れて強火のまま炒めます。
    9.全体に味がなじんだら火からおろし、器に盛りつけて完成です。",

    )
recipe.recipe_ingredients.build(name: "豚小間切れ肉", quantity: "150g")
recipe.recipe_ingredients.build(name: "薄力粉", quantity: "小さじ１")
recipe.save!
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
