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

# キーや値に異なるデータ型を混在させる
# ハッシュのキーは同じデータ型にする必要はないが、無用な混乱を招くので必要ない限りデータ型は揃えた方が良い
# 文字列のキーとシンボルのキーを混在させる
hash = { 'abc' => 123, def: 456 }

# 値を取得する場合はデータ型に合わせてキーを指定する
hash['abc'] # => 123
hash[:def]  # => 456

# データ型が異なると値は取得できない
hash[:abc]  # => nil
hash['def'] # => nil

# 一方、ハッシュに格納する値に関しては、異なるデータ型が混在するケースもよくある
person = {
  # 値が文字列
  name: 'Alice',
  # 値が数値
  age: 20,
  # 値が配列
  friends: ['Bob', 'Carol'],
  # 値がハッシュ
  phones: { home: '1234-0000', mobile: '5678-0000' }
}

person[:age]             # => 20
person[:friends]         # => ["Bob", "Carol"]
person[:phones][:mobile] # => "5678-0000"