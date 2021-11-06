# ハッシュのキーにシンボルを使う

# ハッシュのキーをシンボルにする
currencies = { :japan => 'yen', :us => 'dollar', :india => 'rupee' }
# シンボルを使って値を取り出す
currencies[:us] # => 'dollar'

# 新しいキーと値の組み合わせを追加する
currencies[:italy] = 'eurro'

# シンボルがキーになる場合、 =>を使わずに"シンボル: 値"という記法でハッシュを作成できる。コロンの位置が左から右に変わる
# =>ではなく、"シンボル: 値"の記法でハッシュを作成する
currencies = { japan: 'yen', us: 'dollar', india: 'rupee' }
# 値を取り出すときは同じ
currencies[:us] # => 'dollar'

# キーも値もシンボルの場合は
{ japan: :yen, us: :dollar, india: :rupee }
# 同じことを違う書き方で
{ :japan => :yen, us: :dollar, india: :rupee }
# コロン同士で向き合うので不自然な印象を受けるかもしれないが、Rubyではこのようなハッシュの記述を使っていく

