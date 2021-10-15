# メソッドの定義
def メソッド名(引数1, 引数2)
  # 必要な処理
end

# 例えば
def add(a, b)
  a + b
end
add(1, 2) # => 3

# メソッド名はスネークケースで書く
def hello_world
  'Hello,world!'
end

# キャメルケースは使わない (エラーにならないが一般的ではない)
def helloWorld
  'Hello, world!'
end

# アンダースコアでメソッド名を書き始める (アンダースコアで始まることは少ない)
def _hello_world
  'Hello, world!'
end

# メソッド名に数字を入れる
def hello_world_2
  'Hello, world!!'
end

# 数字から始まるメソッドは使えない (エラーになる)
def 2_hello_world
  'Hello, world!'
end
# => SyntaxError: trailing '_' in number
#    def 2_hello_world
#          ^

# メソッド名をひらがなにする (一般的ではない)
def あいさつする
  'はろー、 わーるど!'
end
# ひらがなのメソッドを呼び出す
あいさつする # => "はろー、 わーるど!"

# メソッドの戻り値

def add (a, b)
  #returnも使えるが、使わない方が主流
  return a + b
end
add(1, 2) # => 3


def greeting(country)
  # "こんにちは"または"hello"がメソッドの戻り値になる
  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end
grreting('japan') # => "こんにちは"
greeting('us')    # => "hello"

def greeting(country)
  # countryがnilならメッセージを返してメソッドを抜ける
  #  (nil?はオブジェクトがnilの場合にtrueを返すメソッド)
  return 'countryを入力してください' if country.nil?

  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end
greeting(nil)      # => "countryを入力してください"
greeting('japan')  # => "こんにちは"

# メソッド定義における引数()

# 引数がない場合は()を付けない方が主流
def greeting
  'こんにちは'
end

# ()をつけても良いが、省略されることが多い
def greeting()
  'こんにちは'
end

# ()を省略できるが、引数がある場合は()をつけることのほうが多い
def greeting country
  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end