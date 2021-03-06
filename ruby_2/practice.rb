# 様々なタイプのオブジェクトに対してto_sメソッド(オブジェクトの内容を文字列化するメソッド)を呼び出すコード例

# 文字列
'1'.to_s # => "1"

# 数値
1.to_s # => "1"

# nil
nil.to_s # => ""

# true
true.to_s # => "true"

# false
false.to_s # => "false"

# 正規表現
/\d+/.to_s # => "(?-mix:\\d+)"

# 数値の1を文字列に変換する(カッコあり)
1.to_s() # => "1"

# 数値の1を文字列に変換する(カッコなし)
1.to_s # => "1"

# 数値を16進数の文字列に変換する(カッコあり)
10.to_s(16) # => "a"

# 数値を16進数の文字列に変換する(カッコなし)
10.to_s 16 # => "a"

# 改行ごとにメソッドが実行される
1.to_s # => "1"
nil.to_s # => ""
10.to_s(16) # => "a"

# セミコロンを使って、3つの文を1行に押し込める
1.to_s; nil.to_s; 10.to_s(16)

# (で改行しているので、カッコが閉じられるまで改行してもエラーにならない
10.to_s(
  16
)  # => "a"

# (がない場合は10.to_sと16という2つの文だとみなされる
10.to_s # => "10"
16 # => "16"

# バックスラッシュを使って10.to_s 16を改行して書く
10.to_s \
16  # => "a"

# この行はコメントです。
1.to_s # 行の途中でもコメントが入れられます。

=begin
ここはコメントです。
ここもコメントです。
ここもコメントです。
=end

# ここはコメントです。
# ここもコメントです。
# ここもコメントです。

# リテラル
# 数値
123

# 文字列
"Hello"

# 配列
[1, 2, 3]

# ハッシュ
{'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee'}

# 正規表現
/\d+-\d+/

# 変数
s = 'Hello'
n = 123*2

# 変数を宣言する目的で変数名だけ書くと、エラーになる
x # => NameError: undefined local variable or method 'x' for main;Object

# 変数を宣言するには何かしらの値を代入する必要がある
x = nil

# 変数名はスネークケースで書く
special_price = 200

# キャメルケースは使わない(エラーにはならないが一般的ではない)
specialPrice = 200

# アンダースコアで変数名を書き始める(あまり使われない)
_special_price = 200

# 変数名に数字を入れる
special_price_2 = 300

# 数字から始まる変数名は使えない(エラーになる)
2_special_price = 300
# => SyntaxError: trailing '_' in number
# 2_special_price = 300
#   ^

# 変数名を漢字にする(一般的ではない)
特別価格 = 200
特別価格 * 2 # => 400

# 同じ変数に文字列や数値を代入する(良いコードではないので注意)
x = 'Hello'
x = '123'
x = 'Good-bye'
x = '456'

# 2つの値を同時に代入する
a, b = 1, 2
a # => 1
b # => 2

# 右辺の数が少ない場合はnilが入る
c, d = 10
c # => 10
d # => nil

#右辺の数が多い場合ははみ出した値が切り捨てられる
e, f = 100, 200, 300
e # => 100
f # => 200

# 2つの変数に同じ値を代入する
a = b = 100
a # => 100
b # => 100

# 文字列
'これは文字列です。'
"これも文字列です。"

# ダブルクオートで囲むと\nが改行文字として機能する
puts "こんにちは\nさようなら"
# => こんにちは
#    さようなら

# シングルクオートで囲むと\nはただの文字列になる
puts 'こんにちは\nさようなら'
# => こんにちは\nさようなら

name = 'Alice'
puts "Hello, #{name}!" # => Hello, Alice!

i = 10
puts "#{i}は16進数にすると#{i.to_s(16)}です" # => 10は16進数にするとaです

name = 'Alice'
puts 'Hello, #{name}!' # => Hello, #{name}!

name = 'Alice'
puts 'Hello,' + name + '!' # => Hello, Alice!

puts "こんにちは\\nさようなら" # => こんにちは\nさようなら

name = 'Alice'
puts 'Hello, \#{name}!' # => Hello, #{name}!

puts 'He said, "Don\'t speak."' # => He said, "Don't speak."

puts "He said, \"Don't speak.\""

# 文字列の比較

'ruby' == 'ruby' # => true
'ruby' == 'Ruby' # => false
'ruby' != 'perl' # => true
'ruby' != 'ruby' # => false

'a' < 'b' # => true
'a' < 'A' # => false
'a' > 'A' # => true
'abc' < 'def'  # => true
'abc' < 'ab'   # => false
'abc' < 'abcd' # => true
'あいうえお' < 'かきくけこ' # => true

# 数値