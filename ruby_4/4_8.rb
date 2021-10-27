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