# ハッシュで使用頻度の高いメソッド
# keys　ハッシュのキーを配列として返す
currencies = { japan: 'yen', us: 'dollar', india: 'rupee' }
currencies.kyes # => [:japan, :us, :india]

# values ハッシュの値を配列として返す
currencies = { japan: 'yen', us: 'dollar', india: 'rupee' }
currencies.values # => ["yen", "dollar", "rupee"]

# has_key?/key?/include?/member?
# has_key?メソッドはハッシュの中に指定されたキーが存在するかどうか確認するメソッド。
currencies = { japan: 'yen', us: 'dollar', india: 'rupee' }
currencies.has_key?(:japan) # => true
currencies.has_key?(:italy) # => false

# **でハッシュを展開させる
# **をハッシュの前につけるとハッシュリテラル内でほかのハッシュのキーと値を展開することができる
h = {us: 'dollar', india: 'rupee' }
# 変数hのキーと値を**で展開させる
{ japan: 'yen', **h } # => {:japan=>"yen", :us=>"dollar", :india=>"ruppe"}

# **をつけない場合は構文エラーになる
{ japan: 'yen', h }
# => SyntaxError: syntax error, unexpected '}', expecting =>
#    { japan: 'yen', h }
#                       ^
# 上のコードは**のかわりにmergeメソッドを使っても同じ結果が得られる
h = {us: 'dollar', india: 'rupee' }
{ japan: 'yen' }.merge(h) # => {:japan=>"yen", :us=>"dollar", :india=>"ruppe"}

# ハッシュを使った擬似キーワード引数
# ハッシュを受け取ってキーワード引数のように見せるテクニックを擬似キーワード引数と呼ぶ
# buy_burgerメソッドを擬似キーワード引数として実装するコード例

# ハッシュを引数として受け取り、擬似キーワード引数を実現する
def buy_burger(menu, options = {})
  drink = options[:drink]
  potato = options[:potato]
  # 省略
end

buy_burger('cheese', drink: true, potato: true)
# キーワード引数を使う場合と比較すると、呼び出し側のコードは同じだが、メソッドの定義はハッシュから値を取り出す分少しコードが増える
# また、キーワード引数は存在しないキーワードを指定するとエラーが発生したが、擬似キーワード引数は単なるハッシュであるため、どんなキーを渡してもエラーは発生しない。無効なキーをエラーにしたい場合は、メソッド内で検証用のコードを書く必要がある
buy_burger('fish', salad: true)

# 特別な要件がない限り、擬似キーワードよりも文法レベルでRuby本体がサポートしてくれるキーワード引数を使った方がメリットが大きい
