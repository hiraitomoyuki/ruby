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

# 任意のキーワードを受け付ける**引数
# キーワード引数を使うメソッドが存在しないキーワードを渡すとエラーが発生する
def buy_burger(menu, drink: true, potato: true)
  # 省略
end

# saladとchickenは無効なキーワード引数なのでエラーになる
buy_burger('fish', drink: true, potato: false, salad: true, chicken: false)
# => ArgumentError: unknown keywords: salad, chicken

# しかし、任意のキーワードも同時に受け取りたい、というケースは**をつけた引数を最後に用意する。**をつけた引数にはキーワード引数で指定されていないキーワードがハッシュとして格納される
# 想定外のキーワードはothers引数で受け取る
def buy_burger(menu, drink: true, potato: true, **others)
  # othersはハッシュとして渡される
  puts others

  # 省略
end

buy_burge('fish', drink: true, potato: false, salad: true, chicken: false)
# => {:salad=>true, :chicken=>false}

# メソッドの呼び出し時の{}の省略
# Rubyでは「最後の引数がハッシュであればハッシュリテラルの{}を省略できる」というルールがある。
# 以下のようにキーワード引数ではなく、引数として純粋にハッシュを受け取りたいメソッドがあるとする

# optionsは任意のハッシュを受け付ける
def buy_burger(menu, options = {})
  puts options
end
# キーワード引数の場合は呼び出し時に必ず引数名をシンボルで指定する必要がある。ここではキーワード引数との違いを明確にするため、以下のように文字列にしたハッシュを渡すことにする
# ハッシュを第2引数として渡す
buy_burger('fish', {'drink' => true, 'potato' => false}) # => {"drink"=>true, "potato"=>false}
# このコードでも大丈夫。ただ、以下のように書き換えてもOK

# ハッシュリテラルの{}を省略してメソッドを呼び出す
buy_burger('fish', 'drink' => true, 'potato' => false) # =>{"drink"=>true, "potato"=>false}

# あくまで「最後の引数がハッシュであれば」という条件があるので、最後の引数にハッシュがきていない場合はエラーになる
# menuとoptionsの順番を入れ替える
def buy_burger(options = {}, menu)
  puts options
end

# optionsは最後の引数ではないので、ハッシュリテラルの{}は省略できない
buy_burger('drink' => true, 'potato' => false, 'fish')
# => SyntaxError: syntax error, unexpected '(', expected =>
#    ue, 'potato' => false, 'fish')
#                                  ^

# 最後の引数でなければ{}をつけて普通にハッシュを作成する
buy_burger({'drink' => true, 'potato' => false}, 'fish') # => {"drink"=>true, "potato"=>false}

# ハッシュリテラルの{}とブロックの{}

# ()ありのメソッド呼び出し
puts('Hello')
# ()なしのメソッド呼び出し
puts 'Hello'

# ()を省略
buy_burger {'drink' => true, 'potato' => false}, 'fish'
# => SyntaxError: syntax error, unexpected =>, expecting '}'
# buy_burger {'drink' => true, 'potato' => false}, 'fi
#                       ^

# これは、ハッシュリテラルの{}がブロックの{}だとRubyに解釈されたが、プログラマはブロックの{}ではなく、ハッシュの{}としてコードを書いてしまっているため、Rubyに構文エラーだと怒られた。
# このようにメソッドの第1引数にハッシュを渡そうとする場合は必ず()をつけてメソッドを呼び出す必要がある
# 第1引数にハッシュの{}が来る場合は()を省略できない
buy_burger({'drink' => true, 'potato' => false}, 'fish')
# 逆に言うと、第2引数以降にハッシュが来る場合は()を省略してもエラーにはならない
def buy_burger(menu, options = {})
  puts options
end

# 第2引数以降にハッシュが来る場合は、()を省略してもエラーにはならない
buy_burger 'fish', {'drink' => true, 'potato' => false}

# この場合、そもそもハッシュが最後の引数なので、{}を省略することもできる
buy_burger 'fish', 'drink' => true, 'potato' => false
# ハッシュリテラルの前後で構文エラーが発生した場合は、()の省略が原因になっていないかチェックが必要

# ハッシュから配列へ、配列からハッシュへ
# ハッシュはto_aメソッドを使って配列に変換することができる。to_aメソッドを使うとキーと値が1つの配列に入り、さらにそれが複数並んだ配列になって返る
currencies = { japan: 'yen', 'us': 'dollar', india: 'rupee' }
currencies.to_a # => [[:japan, "yen"], [:us, "dollar"], [:india, "rupee"]]

# 反対に、配列に対してto_hメソッドを呼ぶと、配列をハッシュに変換することができる。このとき、ハッシュに変換する配列はキーと値の組み合わせごとに1つの配列に入り、それが要素の分だけ配列として並んでいる必要がある
array = [[:japan, "yen"], [:us, "dollar"], [:india, "rupee"]]
array.to_h # => {:japan=>"yen", :us=>"dollar", :india=>"rupee"}

# ハッシュとして解析不能な配列に対してto_hメソッドを呼ぶとエラーになる
array = [1, 2, 3, 4]
array.to_h # => TypeError: wrong element type Integer at 0 (expected array)

# キーが重複した場合は最後に登場した配列の要素がハッシュの値に採用される。だが、思いがけない不具合を生む原因になるので、特別な理由がない限りは必ずユニークにしておく
array = [[:japan, "yen"], [:japan, "円"]]
array.to_h # => {:japan=>"円"}

# to_hメソッドはRuby2.1から登場した比較的新しいメソッド。以前はキーと値のペアの配列をHash[]に対して渡すことで配列をハッシュに変換していた
# キーと値のペアの配列をHash[]に渡す
array = [[:japan, "yen"], [:us, "dollar"], [:india, "rupee"]]
Hash[array] # => {:japan=>"yen", :us=>"dollar", :india=>"rupee"}

# キーと値が交互に並ぶフラットな配列をsplat展開しても良い
array = [:japan, "yen", :us, "dollar", :india, "rupee"]
Hash[*array] # => {:japan=>"yen", :us=>"dollar", :india=>"rupee"}

# Hash[]を使った変換方法は現行のRubyでも有効。昔からメンテナンスされているコードではHash[]が使われているケースもあるはずなので、覚えておくと良い

# ハッシュの初期値を理解する
h = {}
h[:foo] # => nil
# nil以外の値を返したいときは、Hash.newでハッシュを作成し、引数に初期値となる値を指定する

# キーがなければ'hello'を返す
h = Hash.new('hello')
h[:foo] # => "hello"
# ただし、配列の初期値と同様、ここでも参照の概念を理解しておかないと思わぬ不具合を作り込んでしまう可能性がある。newの引数として初期値を指定した場合は、初期値として毎回同じオブジェクトが返る。そのため、初期値に対して破壊的な変更を適用すると、ほかの変数の値も一緒に変わる
h = Hash.new('hello')
a = h[:foo] # => "hello"
b = h[:bar] # => "hello"

# 変数aと変数bは同一オブジェクト
a.equal?(b) # => true

# 変数aに破壊的な変更を適用すると、変数bの値も一緒に変わる
a.upcase!
a # => "HELLO"
b # => "HELLO"

# ちなみにハッシュ自身は空のままになっている
h # => {}

# 文字列や配列など、ミューダブルなオブジェクトを初期値として返す場合はHash.newとブロックを組み合わせて初期値を返すことで、このような問題を避けることができる
# キーが見つからないとブロックがその都度実行され、ブロックの戻り値が初期値になる
h = Hash.new { 'hello' }
a = h[:foo] # => "hello"
b = h[:bar] # => "hello"

# 変数aと変数bは異なるオブジェクト(ブロックの実行時に毎回新しい文字列が作成される)
a.equal?(b) # => false

# 変数aに破壊的な変更を適用しても、変数bの値は変わらない
a.upcase!
a # => "HELLO"
b # => "hello"

# ハッシュは空のまま
h # => {}

# また、Hash.newにブロックを与えると、ブロック引数としてハッシュ自身と見つからなかったキーが渡される。そこでこのブロック引数を使って、ハッシュにキーと初期値も同時に設定するコードもよく使われる
# 初期値を返すだけでなく、ハッシュに指定されたキーと初期値を同時に設定する
h = Hash.new { |hash, key| hash[key] = 'hello' }
h[:foo] # => "hello"
h[:bar] # => "hello"

# ハッシュにキーと値が追加されている
h # => {:foo=>"hello", :bar=>"hello"}