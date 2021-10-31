# Rubyではeachメソッドを使って繰り返し処理を行う場合が大半。しかし、eachメソッドでは何番目の要素を処理しているか、ブロック内で判別できない。
# 繰り返し処理をしつつ、処理している要素の添え字も取得したい時は、each_with_indexメソッドを使うと便利。ブロック引数の第2引数に添え字を渡してくれる
fruits = ['apple', 'orange', 'melon']
# ブロック引数のiには0, 1, 2...と要素の添え字が入る
fruits.each_with_index { |fruit, i| puts "#{i}: #{fruit}" }
# => 0: apple
#    1: orange
#    2: melon

# mapメソッドとwith_indexメソッドを組み合わせて使う
fruits = ['apple', 'orange', 'melon']
# mapとして処理しつつ、添え字も受け取る
fruits.map.with_index { |fruit, i| "#{i}: #{fruit}" }
# => ["0: apple", "1: orange", "2: melon"]

# with_indexメソッドはmap以外のメソッドとも組み合わせることができる
fruits = ['apple', 'orange', 'melon']
# 名前に"a"を含み、なおかつ添え字が奇数である要素を削除する
fruits.delete_if.with_index { |fruit, i| fruit.include?('a') && i.odd? }
# => ["apple", "melon"]

# このメソッドはEnumeratorクラスのインスタンスメソッド。そして、eachメソッドやmapメソッド、delete_ifメソッドなど繰り返し処理を行うメソッドの大半はブロックを省略して呼び出すと、Enumeratorオブジェクトを返す
fruits = ['apple', 'orange', 'melon']
# ブロックなしでメソッドを呼ぶとEnumeratorオブジェクトが返る。よってwith_indexメソッドが呼び出せる
fruits.each      # => <Enumerator: ["apple", "orange", "melon"]:each>
fruits.map       # => <Enumerator: ["apple", "orange", "melon"]:map>
fruits.delete_if # => <Enumerator: ["apple", "orange", "melon"]:delete_if>
# このようになっているため、with_indexメソッドはあたかもさまざまな繰り返し処理用のメソッドと組み合わせて実行できるように見える


# each_with_indexメソッドやwith_indexメソッドを使うと、繰り返し処理中に添え字が取得できて便利だが、添え字はいつも0から始まる
# これを0以外の数値(例えば1や10)から始めたいと思った場合、with_indexに引数を渡す。そうすると、添え字が引数で渡した数値から開始する
fruits = ['apple', 'orange', 'melon']

# eachで繰り返しつつ、1から始まる添え字を取得する
fruits.each.with_index(1) { |fruit, i| puts "#{i}: #{fruit}" }
# => 1: apple
#    2: orange
#    3: melon
# mapで処理しつつ、10から始まる添え字を取得する
fruits.map.with_index(10) { |fruit, i| "#{i}: #{fruit}" }
# => ["10: apple", "11: orange", "12: melon"]

# ちなみに、each_with_indexメソッドには引数を渡せないため、each_with_index(1)ではなく、上のコードのようにeach.with_index(1)の形で呼び出す必要がある


# 配列がブロック引数に渡される場合
dimensions = [
  # [縦, 横]
  [10, 20],
  [30, 40],
  [50, 60],
]
# 面積の計算結果を格納する配列
areas = []
# ブロック引数が1個であれば、ブロック引数の値が配列になる
dimensions.each do |dimension|
  length = dimensions[0]
  width = dimension[1]
  areas << length * width
end
areas # => [200, 1200, 3000]

# ブロック引数の数を2個にすると、盾と横の値を別々に受け取ることができ、上記のコードよりシンプルになる
dimensions = [
  # [縦, 横]
  [10, 20],
  [30, 40],
  [50, 60],
]
# 面積の計算結果を格納する配列
areas = []
# 配列の要素分だけブロック引数を用意すると、各要素の値が別々の変数に格納される
dimensions.each do |length, width|
  areas << length * width
end
areas # => [200, 1200, 3000]

# あまり意味はないが、ブロック引数が多すぎる場合は、はみ出しているブロック引数はnilになる
# lengthとwidthには値が渡されるが、fooとbarはnilになる
dimensions.each do |length, width, foo, bar|
  p [length, width, foo, bar]
end
# => [10, 20, nil, nil]
#    [30, 40, nil, nil]
#    [50, 60, nil, nil]
# 配列の要素が3個あるのに、ブロック引数が2個しかない場合は3つめの値が捨てられるが、わかりづらいので特別な理由がない限りは書かないように
dimensions = [
  [10, 20, 100],
  [30, 40, 200],
  [50, 60, 300],
]
# 3つの値をブロック引数に渡そうとするが、2つしかないので3つめの値は捨てられる
dimensions.each do |length, width|
  p [length, width]
end
# => [10, 20]
#    [30, 40]
#    [50, 60]


# each_with_indexのように、もとからブロック引数を2つ受け取る場合は、

dimensions = [
  [10, 20],
  [30, 40],
  [50, 60],
]
dimensions.each_with_index do |length, width, i|
  puts "length: #{length}, width: #{width}, i: #{i}"
end
# => length: [10, 20], width: 0, i:
#    length: [30, 40], width: 1, i:
#    length: [50, 60], width: 2, i:

# ではなく
dimensions = [
  [10, 20],
  [30, 40],
  [50, 60],
]
# いったん配列のまま受け取る
dimensions.each_with_index do |dimension, i|
  # 配列から縦と横の値を取り出す
  length = dimension[0]
  width = dimensions[1]
  puts "length: #{length}, width: #{width}, i: #{i}"
end
# => length: 10, width: 20, i: 0
#    length: 30, width: 40, i: 1
#    length: 50, width: 60, i: 2
# 一度配列で受け取ってから変数に入れ直すのは面倒だから、配列の要素を受け取るブロック引数を()で囲むと配列の要素を別々の引数として受け取れる
dimensions = [
  [10, 20],
  [30, 40],
  [50, 60],
]
# ブロック引数を()で囲んで、配列の要素を別々の引数として受け取る
dimensions.each_with_index do |(length, width), i|
  puts "length: #{length}, width: #{width}, i: #{i}"
end
# => length: 10, width: 20, i: 0
#    length: 30, width: 40, i: 1
#    length: 50, width: 60, i: 2


# ブロックローカル変数
# ブロック引数を;で区切り、続けて変数を宣言すると、ブロック内でのみ有効な独立したローカル変数を宣言することができる
numbers = [1, 2, 3, 4]
sum = 0
# ブロックの外にあるsumとは別物の変数sumを用意する
numbers.each do |n; sum|
  # 別物のsumを10で初期化し、ブロック引数の値を加算する
  sum = 10
  sum += n
  # 加算した値をターミナルに表示する
  p.sum
end
# => 11
#    12
#    13
#    14
# ブロックの中で使っていたsumは別物なので、ブロックの外のsumには変化がない
sum # => 0
# ブロックローカル変数の明示的な宣言は、ブロックの中と外で"偶然"同じ変数を使ってしまい、不具合を起こす危険性をなくすことができる
# この問題は見通しの良いロジックを書いたり、変数に適切な名前をつけたりすることでほとんど防げる


# 繰り返し処理以外でも使用されるブロック
# テキストファイルに文字列を書き込むコード例
# sample.txtを開いて文字列を書き込む(クローズ処理は自動的に行われる)
File.open("./sample.txt", "w") do |file|
  file.puts("1行目のテキストです。")
  file.puts("2行目のテキストです。")
  file.puts("3行目のテキストです。")
end
# ファイルのような外部リソースを扱う際は「オープンしたら必ずクローズする」と言う処理が必要。
# RubyのFile.openメソッドとブロックを組み合わせると、オープンするだけでなく、「必ずクローズする」という処理までFile.openメソッドが面倒を見てくれる
# よってブロック内でファイルに書き込む内容を記述するだけで済み、「開いたら必ずクローズする」というお約束コードを毎回書かなくてもよくなる


# do...endと{}の結合度の違い
# ブロックはdo...endで書くこともできるし、{}を使って書くこともできる
# 基本的にどちらを使っても結果は同じだが、do...endよりも{}の方が結合度が強い
# 配列のdeleteメソッドにはブロックを渡すことができる。ブロックを渡すと引数で指定した値が見つからないときの戻り値を指定することができる
a = [1, 2, 3]
# ブロックを渡さない時は指定した値が見つからないとnilが返る
a.delete(100) # => nil
# ブロックを渡すとブロックの戻り値が指定した値が見つからないときの戻り値になる
a.delete(100) do
  'NG'
end
# => "NG"

# メソッドの引数を囲む()を省略することができる
a.delete 100 do
  'NG'
end
# => "NG"
# do...endを{}に置き換えて実行
a.delete 100 { 'NG' }
# => SyntaxError: syntax error, unexpected '{', expecting end-of-input

# {}の結合度が強いため、a.delete 100ではなく、100 { 'NG' }と解釈されてしまうため。
# しかし、100はただの数値であり、メソッドではないためブロックを渡すことができず、構文エラーと解釈されてしまう
a.delete(100) { 'NG' }
# => "NG"

# 引数付きのメソッド呼び出しで{}をブロックとして使う場合は、メソッド引数の()を省略できない
