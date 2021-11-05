# ハッシュのキーにシンボルを使う

# ハッシュのキーをシンボルにする
currencies = { :japan => 'yen', :us => 'dollar', :india => 'rupee' }
# シンボルを使って値を取り出す
currencies[:us] # => 'dollar'

# 新しいキーと値の組み合わせを追加する
currencies