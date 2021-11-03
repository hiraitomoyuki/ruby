# ハッシュ
# ハッシュはキーと組み合わせでデータを管理するオブジェクトのこと。他の言語では連想配列やディクショナリ(辞書)、マップと呼ばれたりする場合もある
# ハッシュを作成する場合の構文
# 空のハッシュを作る
{}

# キーと値の組み合わせを3つ格納するハッシュ
{ キー1 => 値1, キー2 => 値2, キー3 => 値3 }

# ハッシュはHashクラスのオブジェクトになっている

# 空のハッシュを作成し、そのクラス名を確認する
{}.class # => Hash

# 国ごとに通過の単位を格納したハッシュを作成する例
{'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }

# 改行して書くことも可能
{
  'japan' => 'yen',
  'us' => 'dollar',
  'india' => 'rupee'
}

# 配列と同様、最後にカンマが付いてもエラーにはならない
{
  'japan' => 'yen',
  'us' => 'dollar',
  'india' => 'rupee',
}

# 同じキーが複数使われた場合は、最後に出てきた値が有効になる。特別な理由がない限りこのようなハッシュを作成する意味はない。むしろ不具合である可能性が高い
{'japan' => 'yen', 'japan' => '円' } # => {"japan"=>"円"}

# ハッシュリテラルで使う{}はブロックで使う{}と使っている記号が同じ

# ハッシュリテラルの{}
h = { 'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }

# ブロックを作成する{}
[1, 2, 3].each { |n| puts n }

# 慣れないうちはハッシュの{}とブロックの{}の見分けがつきにくいかもしれないが、Rubyのコードをたくさん読み書きするうちにぱっと見分けがつくようになる
# 書き方を誤るとRuby自身がハッシュの{}とブロックの{}を取り違えてしまうケースもある。

# 要素の追加、変更、取得
# あとから新しいキーと値を追加する場合は、次のような構文を使う
ハッシュ[キー] = 値

# 新たにイタリアの通過を追加するコード例
currencies = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }
# イタリアの通過を追加する
currencies['italy'] = 'euro'
currencies # => {"japan"=>"yen", "us"=>"dollar", "india"=>"rupee", "italy"=>"euro"}

# すでにキーが存在していた場合は、値が上書きされる
currencies = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }
# 既存の値を上書きする
currencies['japan'] = '円'
currencies # => {"japan"=>"円", "us"=>"dollar", "india"=>"rupee"}

# ハッシュから値を取り出す場合は
ハッシュ[キー]

# ハッシュからインドの通過を取得するコード例
# ハッシュはその内部構造上、キーと値が大量に格納されている場合でも、指定したキーに対応する値を高速に取り出せる
currencies = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }
currencies['india'] # => 'rupee'

# 存在しないキーを指定するとnilが返る
currencies = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }
currencies['brazil'] # => nil

# ハッシュを使った繰り返し処理
# eachメソッドを使うと、キーと値の組み合わせを順に取り出すことができる。キーと値は格納した順に取り出される。ブロック引数がキーと値で2個になっている点に注意
currencies = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }
currencies.each do |key, value|
  puts "#{key} : #{value}"
end
# => japan : yen
#    us : dollar
#    india : rupee

# ブロック引数を1つにするとキーと値が配列に格納される
currencies = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }
currencies.each do |key_value|
  key = key_value[0]
  value = key_value[1]
  puts "#{key} : #{value}"
end
# => japan : yen
#    us : dollar
#    india : rupee

# ハッシュの同値比較、要素数の取得、要素の削除
# ==でハッシュ同士を比較すると、同じハッシュかどうかチェックできる。　このときすべてのキーと値が同じであればtrueが返る。
a = { 'x' => 1, 'y' => 2, 'z' => 3 }

# すべてのキーと値が同じであればtrue
b = { 'x' => 1, 'y' => 2, 'z' => 3 }
a == b # => true

# 並び順が異なっていてもキーと値が全て同じならtrue
c = { 'z' => 3, 'y' => 2, 'x' => 1}
a == c # => true

# キー'x'の値が異なるのでfalse
d = { 'x' => 10, 'y' => 2, 'z' => 3 }
a == d # => false

# sizeメソッド(エイリアスメソッドはlength)を使うとハッシュの要素の個数を調べることができる
{}.size # => 0
{ 'x' => 1, 'y' => 2, 'z' => 3 }.size # => 3

# deleteメソッドを使うと指定したキーに対応する要素を削除できる。戻り値は削除された要素の値
currencies = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }

# 削除しようとしたキーが見つからないときはnilが返る
currencies.delete('italy') # => nil

# ブロックを渡すとキーが見つからない時の戻り値を作成できる
currencies.delete('italy') { |key| "Not found: #{key}" } # => "Not found: italy"