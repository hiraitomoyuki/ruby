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
