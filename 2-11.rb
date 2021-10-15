# デフォルト値付きの引数

# Rubyではメソッドを呼び出す際に引数の過不足があるとエラーになる
def greeting(country)
  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end

# 引数が少ない
greeting
# => ArgumentError: wrong number of arguments (given 0, expected 1)

# 引数がちょうど
greeting('us') # => "hello"

# 引数が多い
greeting('us', 'japan')
# => ArgumentError: wrong number of arguments (given 2, expected 1)


# 引数なしの場合はcountryに'japan'を設定する
def greeting(country = 'japan')
  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end

greeting       # => "こんにちは"
greeting('us') # => "hello"

def default_args(a,b, c = 0, d = 0)
  "a=#{a}, b=#{b}, c=#{c}, d=#{d}"
end
default_args(1, 2)       # => "a=1, b=2, c=0, d=0"
default_args(1, 2, 3)    # => "a=1, b=2, c=3, d=0"
default_args(1, 2, 3, 4) # => "a=1, b=2, c=3, d=4"

# システム日時やほかのメソッドの戻り値をデフォルト値に指定する
def foo(time = Time.now, message = bar)
  puts "time: #{time}, message: #{message}"
end

def bar
  'BAR'
end

foo # => time: 2017-05-10 09:16:35 +0900, message: BAR


# ?で終わるメソッド
# ?で終わるメソッドは慣習として真偽値を返すメソッド

# 空文字列であればtrue、そうでなければfalse
''.empty?    # => true
'abc'.empty? # => false

# 引数の文字列が含まれていればtrue、そうでなければfalse
'watch'.include?('at') # => true
'watch'.include?('in') # => false

# 奇数ならtrue、偶数ならfalse
1.odd? # => true
2.odd? # => false

# 偶数ならtrue、奇数ならfalse
1.even? # => false
2.even? # => true

# オブジェクトがnilであればtrue、そうでなければfalse
nil.nil?   # => true
'abc'.nil? # => false
1.nil?     # => false

# ?で終わるメソッドは自分で定義することもできる。真偽値を返す目的のメソッドであれば、?で終わらせる
# 3の倍数ならtrue、それ以外はfalseを返す
def multiple_of_three?(n)
  n % 3 == 0
end
multiple_of_three?(4) # => false
multiple_of_three?(5) # => false
multiple_of_three?(6) # => true


# !で終わるメソッド
# !で終わるメソッドは慣習として「使用する際は注意が必要」という意味を持つ

a = 'ruby'

# upcaseだと変数aの値は変化しない
a.upcase # => "RUBY"
a        # => "ruby"

# upcase!だと変数aの値も大文字に変わる
a.upcase! # => "RUBY"
a         # => "RUBY"

# upcase!メソッドのように、呼び出したオブジェクトの状態を変更してしまうメソッドのことを「破壊的メソッド」と呼ぶ

def reverse_upcase!(s)
  s.reverse!.upcase!
end
s = 'ruby'
reverse_upcase!(s) # => "YBUR"
s # => "YBUR"


odd? = 1.odd?
# => SyntaxError: syntax error, unexpected '='
#    odd? = 1.odd?
#          ^

upcase! = 'ruby'.upcase!
# => SyntaxError: syntax error, unexpected '='
#    upcase! = 'ruby'.upcase!
#             ^