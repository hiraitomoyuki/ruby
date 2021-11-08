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

# メソッドのキーワード引数とハッシュ
# メソッドに引数を渡す場合、どの引数がどんな意味を持つかわかりづらい時がある
def buy_burger(menu, drink, potato)
  # ハンバーガーを購入
  if drink
    # ドリンクを購入
  end
  if potato
    # ポテトを購入
  end
end

# チーズバーガーとドリンクとポテトを購入する
buy_burger('cheese', true, true)

# フィッシュバーガーとドリンクを購入する
buy_burger('fish', true, false)

# ここではちゃんと引数を確認したあとなので、特に違和感はないかもしれないが、特に説明もなく次のようなコードを見せられたら
buy_burger('cheese', true, true)
buy_burger('fish', true, false)

# メソッドのキーワード引数は次のように定義する
def メソッド名(キーワード引数1: デフォルト値1, キーワード引数2: デフォルト値2)
  # メソッドの実装
end

def buy_burger(menu, drink: true, potato: true)
  # 省略
end

# キーワード引数を持つメソッドを呼び出すときはハッシュを作成した時と同じように"シンボル: 値"の形式で引数を指定する
buy_burger('cheese', drink: true, potato: true)
buy_burger('fish', drink: true, potato: false)

# キーワード引数にはデフォルト値が設定されているので、引数を省略することもできる
# drinkはデフォルト値のtrueを使うので設定しない
buy_burger('fish', potato: false)

# drinkもpotatoもデフォルト値のtrueを使うので指定しない
buy_burger('cheese')

# キーワード引数は呼び出しの順番を自由に入れ替えることができる
buy_burger('fish', potato: false, drink: true)

# 存在しないキーワード引数を指定した場合はエラーになる
buy_burger('fish', salad: true) # => ArgumentError: unknon keyword: salad

# キーワード引数のデフォルト値は省略することもできる。デフォルト値を持たないキーワード引数は呼び出し時に省略することができない
# デフォルト値なしのキーワード引数を使ってメソッドを定義する
def buy_burger(menu, drink:, potato:)
  # 省略
end
# キーワード引数を指定すれば、デフォルト値ありの場合と同じように使える
buy_burger('cheese', drink: true, potato: true)
# キーワード引数を省略するとエラーになる
buy_burger('fish', potato: false) # => ArgumentError: missing keywords: drink

# キーワード引数を使うメソッドを呼び出す場合、キーワード引数に一致するハッシュ(キーはシンボル)を引数として渡すこともできる。
# キーワード引数と一致するハッシュであれば、メソッドの引数として渡すことができる
params = { drink: true, potato: false }
buy_burger('fish', params)
