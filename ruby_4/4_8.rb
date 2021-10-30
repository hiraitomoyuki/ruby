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