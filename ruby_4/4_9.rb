# さまざまな繰り返し処理

# timesメソッド
# 配列を使わずに、単純にn回処理を繰り返したい、という場合はIntegerクラスのtimesメソッドを使うと便利
sum = 0
# 処理を5回繰り返す。nには0, 1, 2, 3, 4が入る
5.times { |n| sum += n }
sum # => 10
# 不要であればブロック引数は省略してもok
sum = 0
# sumに1を加算する処理を5回繰り返す
5.times { sum += 1 }
sum # => 5

# uptoメソッドとdowntoメソッド
# nからmまで数値を1つずつ増やしながら何か処理したい場合は、Integerクラスのuptoメソッドを、数値を減らしていきたい場合はdowntoメソッドを使う
a = []
10.upto(14) { |n| a << n }
a # => [10, 11, 12, 13, 14]

a = []
14.downto(10) { |n| a << n }
a # => [14, 13, 12, 11, 10]

# stepメソッド
# 1, 3, 5, 7のようにnからmまで数値をx個ずつ増やしながら何か処理したい場合は、Numericクラスのstepメソッドを使う
開始値.step(上限値, 1度に増減する大きさ)

a = []
1.step(10, 2) { |n| a << n }
a # => [1, 3, 5, 7, 9]

# 10から1まで2ずつ値を減らす場合
a = []
10.step(1, -2) { |n| a << n }
a # => [10, 8, 6, 4, 2]

# while文とuntil文
# Rubyには繰り返し処理用の構文も用意されている。その1つがwhile文。while文は指定した条件が真である間、処理を繰り返す
while 条件式 (真であれば実行)
  繰り返したい処理
end

# 配列の要素数が5になるまで値を追加する
a = []
while a.size < 5
  a << 1
end
a # => [1, 1, 1, 1, 1]

# 条件式の後ろにdoを入れると1行で書くこともできる
a = []
while a.size < 5 do a << 1 end
# => [1, 1, 1, 1, 1]

# しかし、1行で書くのであれば修飾子としてwhile文を後ろにおいた方がスッキリかける
a = []
a << 1 while a.size < 5
a # => [1, 1, 1, 1, 1]

# どんな条件でも最低1回は実行したい、という場合はbegin ... endで囲んでからwhileを書く
a = []

while false
  # このコードは常に条件が偽になるので実行されない
  a << 1
end
a # => []

# begin ... endで囲むとどんな条件でも最低1回は実行される
begin
  a << 1
end while false
a # => [1]

# while文の反対で、条件が偽である間、処理を繰り返すuntil文もある
# 繰り返しの条件が逆になること以外は、while文と使い方は同じ。

# 配列の要素数が3以下になるまで配列の要素を後ろから削除していく
a = [10, 20, 30, 40, 50]
until a.size <= 3
  a.delete_at(-1)
end
a # => [10, 20, 30]
# while文もuntil文も、条件式を間違えたり、いつまでたっても上限式の結果が変わらないようなコードを書いたりすると無限ループしてしまう


# for文
# 配列やハッシュはfor文で繰り返し処理することもできる
for 変数 in 配列やハッシュ
  繰り返し処理
end

# 上記では「配列やハッシュ」と書いたが、厳密にはeachメソッドを定義しているオブジェクトであればなんでも良い
numbers = [1, 2, 3, 4]
sum = 0
for n in numbers
  sum += n
end
sum # => 10

# doを入れて1行で書くことも可能
sum = 0
for n in numbers do sum += n end
sum # => 10

# とはいえ、上のfor文は実質的にeachメソッドを使った次のコードとほぼ同じ。Rubyのプログラムでは通常、for文よりもeachメソッドを使う
numbers = [1, 2, 3, 4]
sum = 0
numbers.each do |n|
  sum += n
end
sum # => 10

# 厳密に言うと全く同じではなく、for文の場合は配列の要素を受け取る変数や、for文の中で作成したローカル変数がfor文の外でも使える、という違いがある。
numbers = [1, 2, 3, 4]
sum = 0
numbers.each do |n|
  sum_value = n.even? ? n * 10 : n
  sum += sum_value
end
# ブロック引数やブロック内で作成した変数はブロックの外では参照できない
n         # => NameError: undefined local variable or method 'n' for main:Object
sum_value # => NameError: undefined local variable or method 'sum_value' for main:Object

sum = 0
for n in numbers
  sum_value = n.even? ? n * 10 : n
  sum += sum_value
end
# for文の中で作成された変数はfor文の外でも参照できる
n         # => 4
sum_value # => 40

# loopメソッド