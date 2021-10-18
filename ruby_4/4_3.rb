# Rubyの繰り返し処理
# doからendまでがブロックの範囲
numbers = [1, 2, 3, 4]
sum = 0
numbers.each do |n|
  sum += n
end
sum # => 10
# |n|はnのブロック引数と呼ばれるもので、eachメソッドから渡された配列の要素が入る


# 配列の要素を削除する条件を自由に指定
a = [1, 2, 3, 1, 2, 3]
# 配列から値が奇数の要素を削除する
a.delete_if do |n|
  n.odd?
end
a # => [2, 2]

# delete_ifはブロックの戻り値をチェックする。その戻り値が真であれば、ブロックに渡した要素を配列から削除
# 偽であれば配列に残したままにする。
# odd?メソッドは数値が奇数の場合にtrueを返す。
# delete_ifメソッドは「配列の要素を順番に取り出すこと」と「ブロックの戻り値が真であれば要素を削除すること」の共通処理を提供
# どの要素を削除したいかは要件によって異なるのでブロックに処理をゆだねる。
# そのため、プログラマはブロックの内部に自分の要件にあった処理を記述し、delete_ifメソッドの使用に合わせて真または偽の値を返すようにする

numbers = [1, 2, 3, 4]
sum = 0
numbers.each do |n|
  sum += n
end

# ブロック引数の名前はなんでも良い
numbers.each do |i|
  sum += i
end

numbers.each do |number|
  sum += number
end

numbers.each do |element|
  sum += element
end

# 引数を使わない場合は書かなくても可
numbers.each do
  sum += 1
end

# 偶数のみ値を10倍にして加算する
numbers = [1, 2, 3, 4]
sum = 0
numbers.each do |n|
  sum_value = n.even? ? n * 10 : n
  sum += sum_value
end
sum # => 64


# sum_valueはブロック内で初めて登場した変数なので、変数のスコープはブロックの内部のみ
numbers = [1, 2, 3, 4]
sum = 0
numbers.each do |n|
  # sum_valueはブロック内で初めて登場した変数なので、ブロック内でのみ有効
  sum_value = n.even? ? n * 10 : n
  sum += sum_value
end
# ブロックの外に出ると、sum_valueは参照できない
sum_value
# => NameError: undefined lacal variable or method 'sum_value' for main:Object

# 一方、ブロックの外部で作成されたローカル変数はブロックの内部でも参照可
numbers = [1, 2, 3, 4]
sum = 0
numbers.each do |n|
  sum_value = n.even? ? n * 10 : n
  # sumはブロックの外で作成されたので、ブロックの内部でも参照可
  sum += sum_value
end

# ブロック引数の名前をブロックの外にある変数の名前と同じにすると、ブロック内ではブロック引数の値が優先される
numbers = [1, 2, 3, 4]
sum = 0
sum_value = 100
# ブロックの外にもsum_valueはあるが、ブロック内ではブロック引数のsum_valueが優先される
numbers.each do |sum_value|
  sum += sum_value
end
sum # => 10


# Rubyの文法上、改行を入れなくてもブロックは動作する
numbers = [1, 2, 3, 4]
sum = 0
# ブロックをあえて改行させずに書く
numbers.each do |n| sum += n end
sum # => 10

# do...endの代わりに{}で囲んでもブロックを作成可
numbers = [1, 2, 3, 4]
sum = 0
# do ... endの代わりに{}を使う
numbers.each { |n| sum += n }
sum # => 10

# do ... endと{}はどちらも同じブロックなので、{}を使い、ブロックの内部を改行させることも可
numbers = [1, 2, 3, 4]
sum = 0
# {}でブロックを作り、なおかつ改行を入れる
numbers.each { |n|
  sum += n
}
sum # => 10

# 使い分けは明確に決まっていないが、改行を含む長いブロックの時はdo...end、1行でコンパクトに書きたい時は{}
