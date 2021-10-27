# 配列

# 添え字を使うと、添え字の位置と取得する長さを指定することができる。
配列[位置, 取得する長さ]

# 2つめの要素から3つ分の要素を取り出す
a = [1, 2, 3, 4, 5]
a[1, 3] # => [2, 3, 4]

# values_atメソッドを使うと、取得したい要素の添え字を複数指定できる
a = [1, 2, 3, 4, 5]
a.values_at(0, 2, 4) # => [1, 3, 5]

# [配列の長さ-1]を指定すると、最後の要素を取得できる
a = [1, 2, 3]
# 最後の要素を取得する
a[a.size - 1] # => 3

# Rubyでは添え字に負の値が使える。-1は最後の要素、-2は最後から2番目の要素というような指定も可
a = [1, 2, 3]
# 最後の要素を取得する
a[-1] # => 3
# 最後から2番目の要素を取得する
a[-2] # => 2
# 最後から2番目の要素から2つの要素を取得する
a[-2, 2] # => [2, 3]

# 配列にはlastというメソッドがあり、これを呼ぶと配列の最後の要素を取得することができる。引数に0以上の数値を渡すと、最後のn個の要素を取得できる。
a = [1, 2, 3]
a.last    # => 3
a.last(2) # => [2, 3]

# lastの反対のfirstもある。先頭の要素を取得するメソッド
a = [1, 2, 3]
a.first    # => 1
a.first(2) # => [1, 2]