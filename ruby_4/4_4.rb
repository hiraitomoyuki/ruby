# ブロックを使う配列のメソッド

# map/collect
# 各要素に対してブロックを評価した結果を新しい配列にして返す
numbers = [1, 2, 3, 4, 5]
new_numbers = []
numbers.each { |n| new_numbers << * 10 }
new_numbers # => [10, 20, 30, 40, 50]

numbers = [1, 2, 3, 4, 5]
# ブロックの戻り値が新しい配列の各要素になる
new_numbers = numbers.map { |n| n * 10 }
new_numbers # => [10, 20, 30, 40, 50]

# select/find_all/reject
# 各要素に対してブロックを評価し、その戻り値が真の要素を集めた配列を返す
numbers = [1, 2, 3, 4, 5, 6]
# ブロックの戻り値が真になった要素だけが集められる
even_numbers = numbers.select { |n| n.even? }
even_numbers # => [2, 4, 6]
# rejectメソッドはselectメソッドの反対で、ブロックの戻り値が真になった要素を除外した配列を返す
numbers = [1, 2, 3, 4, 5, 6]
# 3の倍数を除外する
non_multiples_of_three = numbers.reject { |n| n % 3 == 0 }
non_multiples_of_three # => [1, 2, 4, 5]

# find/detect
# ブロックの戻り値が真になった最初の要素を返す
numbers = [1, 2, 3, 4, 5, 6]
# ブロックの戻り値が最初に真になった要素を返す
even_number = numbers.find { |n| n.even? }
even_number # => 2

# inject/reduce
# たたみ込み演算を行うメソッド
# eachメソッドを使って1から4までの値を変数sumに加算していく
numbers = [1, 2, 3, 4]
sum = 0
numbers.each { |n| sum += n }
sum # => 10

numbers = [1, 2, 3, 4]
sum = numbers.inject(0) { |result, n| result + n }
sum # => 10
# ブロックの第1引数は初回のみinjectメソッドの引数(ここでは0)が入る。2回目以降は前回のブロックの戻り値が入る。
# ブロックの戻り値は次の回に引き継がれ、ブロックの第1引数(result)に入る。繰り返し処理が最後まで終わると、ブロックの戻り値がinjectメソッドの戻り値になる。
# 1回目:result=0、n=1で、0+1。これが次のresultに入る
# 2回目:result=1、n=2で、1+2。この結果が次のresultに入る
# 3回目:result=3、n=3で、3+3。この結果が次のresultに入る
# 4回目:result=6、n=4で、4+6。最後の要素に達したのでこれがinjectメソッドの戻り値になる。

# 文字列に対しても
['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].inject('Sun') { |result, s| result + s}
# => "SunMonTueWedThuFriSat"


# &とシンボルを使ってもっと簡潔に書く
# 下記のコードは書き換え可能
['ruby', 'java', 'perl'].map { |s| s.upcase } # => ["RUBY", "JAVA", "PERL"]
# こうなる
['ruby', 'java', 'perl'].map (&:upcase)       # => ["RUBY", "JAVA", "PERL"]

[1, 2, 3, 4, 5, 6].select { |n| n.odd? } # => [1, 3, 5]
[1, 2, 3, 4, 5, 6].select (&:odd?)       # => [1, 3, 5]
# mapメソッドやselectメソッドにブロックを渡す代わりに、&:メソッド名という引数を渡しています。以下は使用条件
# ①ブロックの引数が1個だけ
# ②ブロックの中で呼び出すメソッドには引数がない
# ③ブロックの中では、ブロック引数に対してメソッドを1回呼び出す以外の処理がない。

# &:メソッド名に書き換えることができない例
# ブロックの中でメソッドではなく演算子を使っている
[1, 2, 3, 4, 5, 6]select { |n| n % 3 == 0 }

# ブロック内のメソッドで引数を渡している
[9, 10, 11, 12].map { |n| n.to_s(16) }

# ブロックの中で複数の文を実行している
[1, 2, 3, 4].map do |n|
  m = n * 4
  m.to_s
end