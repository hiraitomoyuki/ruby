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