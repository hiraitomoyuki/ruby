# 範囲(Range)
# Rubyには「1から5まで」「文字'a'から文字'e'まで」のように、値の範囲を表すオブジェクトがある。
# 範囲オブジェクトは..または...を使って作成する。
# 最初の値..最後の値(最後の値を含む)
# 最初の値...最後の値(最後の値を含まない)
1..5
1...5
'a'..'e'
'a'...'e'

# 範囲オブジェクトはRangeクラスのオブジェクト
(1..5).class  # => Range
(1...5).class # => Range

# ..と...の違いは、最後の値を範囲に含めるか含めないかの違い。include?メソッドを使うと引数の値が含まれるかどうか確認できる

# ..を使うと5が範囲に含まれる(1以上5以下)
range = 1..5
range.include?(0)   # => false
range.include?(4.9) # => true
range.include?(5)   # => true
range.include?(6)   # => false

# ...を使うと5が範囲に含まれない(1以上5未満)
range = 1...5
range.include?(0)   # => false
range.include?(1)   # => true
range.include?(4.9) # => true
range.include?(5)   # => false
range.include?(6)   # => false

# 範囲オブジェクトを変数に入れず、直接include?のようなメソッドを呼び出す時は範囲オブジェクトを()で囲む必要がある
# ()で囲まずにメソッドを呼び出すとエラーになる
1..5.include?(1)   # => NoMethodError: undefined method 'include?' for 5:Fixnum
# ()で囲めばエラーにならない
(1..5).include?(1) # => true

# これは..や...の優先順位が低いため。
1..(5.include?(1)) # と解釈されたため、エラーとなった


# 配列や文字列の一部を抜き出す

# 配列に対して添え字の代わりに範囲オブジェクトを渡すと、指定した範囲の要素を取得することができる
a = [1, 2, 3, 4, 5]
# 2番目から4番目までの要素を取得する
a[1..3] # => [2, 3, 4]
# 文字列に対しても同じような操作が可能
a = 'abcdef'
# 2文字目から4文字目までを抜き出す
a[1..3] # => "bcd"

# n以上m以下、n以上m未満の判定をする
# n以上m以下、n以上m未満の判定をしたい場合は、<や>=のような記号(不等号)を使うよりも範囲オブジェクトを使ったほうがシンプルに書ける

# 不等号を使う場合
def liquid?(temperature)
  # 0度以上100度未満であれば液体、と判定したい
  0 <= temperature && temperature < 100
end
liquid?(-1)  # => false
liquid?(0)   # => true
liquid?(99)  # => true
liquid?(100) # => false

# 範囲オブジェクトを使う場合
def liquid?(temperature)
  (0...100).include?(temperature)
end
liquid?(-1)  # => false
liquid?(0)   # => true
liquid?(99)  # => true
liquid?(100) # => false


# case文で使う
# 範囲オブジェクトはcase文と組み合わせることもできる。
def charge(age)
  case age
  # 0歳から5歳までの場合
  when 0..5
    0
  # 6歳から12歳までの場合
  when 6..12
    300
  # 13歳から18歳までの場合
  when 13..18
    600
  # それ以外の場合
  else
    1000
  end
end
charge(3)  # => 0
charge(12) # => 300
charge(16) # => 600
charge(25) # => 1000


# 値が連続する配列を作成する
# 範囲オブジェクトに対してto_aメソッドを呼び出すと、値が連続する配列を作成することができる
(1..5).to_a  # => [1, 2, 3, 4, 5]
(1...5).to_a # => [1, 2, 3, 4]

('a'..'e').to_a  # => ["a", "b", "c", "d", "e"]
('a'...'e').to_a # => ["a", "b", "c", "d"]

('bad'..'bag').to_a  # => ["bad", "bae", "baf", "bag"]
('bad'...'bag').to_a # => ["bad", "bae", "baf"]

# []の中に*と範囲オブジェクトを書いても同じように配列を作ることができる(*を使って複数の値を配列に展開することをsplat展開という)
[*1..5]  # => [1, 2, 3, 4, 5]
[*1...5] # => [1, 2, 3, 4]


# 繰り返し処理を行う
# 範囲オブジェクトを配列に変換すれば、配列として繰り返し処理を行うことができる
numbers = (1..4).to_a
sum = 0
numbers.each { |n| sum += n }
sum # => 10
# 配列に変換しなくても、範囲オブジェクトに対して直接eachメソッドを呼び出すことも可能
sum = 0
# 範囲オブジェクトに対して直接eachメソッドを呼び出す
(1..4).each { |n| sum += n }
sum # => 10

# stepメソッドを呼び出すと、値を増やす間隔も指定できる
numbers = []
# 1から10まで2つ飛ばしで繰り返し処理を行う
(1..10).step(2) { |n| numbers << n }
numbers # => [1, 3, 5, 7, 9]