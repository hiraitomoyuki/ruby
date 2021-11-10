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