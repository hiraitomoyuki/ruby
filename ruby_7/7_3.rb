# クラスの定義
# Rubyのクラスを定義する場合は
class クラス名
end
# クラス名は必ず大文字で始める。小文字で始めると構文エラーになる。慣習として、UserやOrderItemのようにキャメルケースで書くのが一般的
# Userクラスの定義
class User
end

# OrderItemクラスの定義
class OrderItem
end

# オブジェクトの作成とinitializeメソッド
# クラスからオブジェクトを作成する場合は以下のようにnewメソッドを使う
User.new
# この時に呼ばれるのがinitializeメソッド。インスタンスを初期化するために実行したい処理があれば、このinitializeメソッドでその処理を実装する(とくに必要がなければ定義しなくても大丈夫)
class User
  def initialize
    puts 'Initialized.'
  end
end
User.new
# => Initialized.
# initializeメソッドは特殊なメソッドで、外部から呼び出すことはできない(デフォルトでprivateメソッドになっている)
user = User.new
user.initialize
# => NoMethodError: private method 'initialize' called for #<User:0x007fb18a321ca0>

# initializeメソッドに引数をつけると、newメソッドを呼ぶ時にも引数が必要になる
class User
  def initialize(name, age)
    puts "name: #{name}, age: #{age}"
  end
end
User.new # => ArgumentError: wrong number of arguments (given 0, expected 2)
User.new('Alice', 20) # => name: Alice, 20

# インスタンスメソッドの定義
# クラス構文の内部でメソッドを定義すると、そのメソッドはインスタンスメソッドになる。インスタンスメソッドはその名の通り、そのクラスのインスタンスに対して呼び出すことができるメソッド
class User
  # インスタンスメソッドの定義
  def hello
    "Hello!"
  end
end

user = User.new
# インスタンスメソッドの呼び出し
user.hello # => "Hello!"

# インスタンス変数とアクセサメソッド
# クラスの内部ではインスタンス変数を使うことができる。インスタンス変数と同じインスタンス(同じオブジェクト)の内部で共有される変数。インスタンス変数の変数名は必ず@で始める
class User
  def initialize(name)
    # インスタンス作成時に渡された名前をインスタンス変数に保存する
    @name = name
  end

  def hello
    # インスタンス変数に保存されている名前を表示する
    "Hello, I am #{@name}."
  end
end
user = User.new('Alice')
user.hello # => "Hello, I am Alice."
# 一方、メソッドやブロックの内部で作成される変数のことをローカル変数と呼ぶ。ローカル変数はメソッドやブロックの内部でのみ有効。またメソッドやブロックが呼び出されるたびに毎回作り直される。ローカル変数はアルファベットの小文字、またはアンダースコアで始める
class User
  # 省略

  def hello
    # shufled_name = @name.chars.shuffle.join
    "Hello, I am #{shuffled_name}."
  end
end
user = User.new('Alice')
user.hello # => "Hello, I am cieAl."
# ローカル変数は参照する前に必ず=で値を代入して作成する必要がある。まだ作成されていないローカル変数を参照しようとするとエラーが発生する
class User
  # 省略

  def hello
    # わざとローカル変数への代入をコメントアウトする
    # shufled_name = @name.chars.shuffle.join
    #"Hello, I am #{shuffled_name}."
  end
end
user = User.new('Alice')
# いきなりshuffled_nameを参照したのでエラーになる
user.hello # => NameError: undefined local variavle or method 'shuffled_name'
           #    for #<User:0x007fb18a211cc0 @name="Alice">

# 一方、インスタンス変数は作成(値を代入)する前にいきなり参照してもえらーにはならない。まだ作成されていないインスタンス変数を参照した場合はnilが返る
class User
  def initialize(name)
    # わざとインスタンス変数への代入をコメントアウトする
    # @name = name
  end

  def hello
    "Hello, I am #{@name}."
  end
end
user = User.new('Alice')
# @nameを参照するとnilになる(つまり名前の部分に何も出ない)
user.hello # => "Hello, I am ."

# このため、インスタンス変数名をうっかりタイプミスすると、思いがけない不具合の原因になる。
class User
  def initialize(name)
    @name = name
  end

  def hello
    # 間違って@nameを@mameと書いてしまった！(@nameはnilになる)
    "Hello, I am #{@mame}."
  end
end
user = User.new('Alice')
# タイプミスに気づいていないと、名前が出ないことにびっくりするはず
user.hello # => "Hello, I am ."

# インスタンス変数はクラスの外部から参照することができない。もし参照したい場合は参照用のメソッドを作る必要がある
class User
  def initialize(name)
    @name = name
  end

  # @nameを外部から参照するためのメソッド
  def name
    @name
  end
end
user = User.new('Alice')
# nameメソッドを経由して@nameの内容を取得する
user.name # => 'Alice'

# 同じく、インスタンス変数の内容を外部から変更したい場合も変更用のメソッドを定義する。Rubyは=で終わるメソッドを定義すると、変数に代入するような形式でそのメソッドを呼び出すことができる
class User
  def initialize(name)
    @name = name
  end

  # @nameを外部から参照するためのメソッド
  def name
    @name
  end

  # @nameを外部から変更するためのメソッド
  def name=(value)
    @name = value
  end
end
user = User.new('Alice')
# 変数に代入しているように見えるが、実際はname=メソッドを呼び出している
user.name = 'Bob'
user.name # => 'Bob'

# このようにインスタンス変数の値を読み書きするメソッドのことを「アクセサメソッド」と呼ぶ。(他の言語では「ゲッターメソッド」や「セッターメソッド」と呼ぶこともある)
# Rubyの場合、単純にインスタンス変数の内容を外部から読み書きするのであれば、attr_accessorというメソッドを使って退屈なメソッド定義を省略することができる。attr_accessorメソッドを使うと、上記のコードは次のように書き換えられる
class User
  # @nameを読み書きするメソッドが自動的に定義される
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  # nameメソッドやname=メソッドを明示的に定義する必要がない
end
user = User.new('Alice')
# @nameを変更する
user.name = 'Bob'
# @nameを参照する
user.name # => 'Bob'

# インスタンス変数の内容を読み取り専用にしたい場合はattr_accessorの代わりにattr_readerメソッドを使う
class User
  # 読み取り用のメソッドだけを自動的に定義する
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
user = User.new('Alice')
# @nameの参照はできる
user.name # => 'Alice'

# @nameを変更しようとするとエラーになる
user.name = 'Bob'
# => NoMethodError: undefined method 'name=' for #<User:0x007fb18a292230 @name="Alice">

# 逆に書き込み専用にしたい場合はattr_writerを使う
class User
  # 書き込み用のメソッドだけを自動的に定義する
  attr_writer :name

  def initialize(name)
    @name = name
  end
end
user = User.new('Alice')
# @nameは変更できる
user.name = 'Bob'

# @nameの参照はできない
user.name
# => NoMethodError: undefined method 'name' for #<User:0x007fb18c000150 @name="Bob">

# カンマで引数を渡すと、複数のインスタンス変数に対するアクセサメソッドを作成することもできる
class User
  # @nameと@ageへのアクセサメソッドを定義する
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end
user = User.new('Alice', 20)
user.name # => "Alice"
user.age # => 20

# クラスメソッドの定義
# クラス構文の内部で普通にメソッドを定義すると、そのメソッドはインスタンスメソッドになる。
# インスタンスメソッドはそのクラスのインスタンスに対して呼び出すことができるメソッドであり、インスタンスに含まれるデータ(つまりインスタンス変数)を読み書きする場合はインスタンスメソッドを定義する。
class User
  def initialize(name)
    @name = name
  end

  # これはインスタンスメソッド
  def hello
    # @nameの値はインスタンスによって異なる
    "Hello, I am #{@name}."
  end
end
alice = User.new('Alice')
# インスタンスメソッドはインスタンス(オブジェクト)に対して呼び出す
alice.hello # => "Hello, I am Alice."

bob = User.new('Bob')
# インスタンスによって内部のデータが異なるので、helloメソッドの結果も異なる
bob.hello # => "Hello, I am Bob."

# 一方、そのクラスに関連は深いものの、ひとつひとつのインスタンスに含まれるデータは使わないメソッドを定義したい場合もある。そのような場合はクラスメソッドを定義した方が使い勝手がよくなる。
# クラスメソッドを定義する方法の1つは、以下のようにメソッド名の前にself.をつける
# クラスメソッドを定義する方法 その1
class クラス名
  def self.クラスメソッド
    # クラスメソッドの処理
  end
end

# もう一つは次のようにclass << selfからendの間にメソッドを書く方法
# クラスメソッドを定義する方法 その2
class クラス名
  class << self
    def クラスメソッド
      # クラスメソッドの処理
    end
  end
end

# 後者の方法はネストが1段深くなるが、その代わりにクラスメソッドをたくさん定義したい場合はメソッド名の前に毎回self.をつけなくても済む
# クラスメソッドを呼び出す場合は、クラス名の直後にドット(.)をつけてメソッドを呼び出す
クラス名.メソッド名

class User
  def initialize(name)
    @name = name
  end

  # self.をつけるとクラスメソッドになる
  def self.create_users(names)
    names.map do |name|
      User.new(name)
    end
  end

  # これはインスタンスメソッド
  def hello
    "Hello, I am #{@name}."
  end
end

names = ['Alice', 'Bob', 'Carol']
# クラスメソッドの呼び出し
users = User.create_users(names)
users.each do |user|
  # インスタンスメソッドの呼び出し
  puts users.hello
end
# => Hello, I am Alice.
#    Hello, I am Bob.
#    Hello, I am Carol.

# ここではUser.create_usersのようなメソッドをクラスメソッドと読んだが、このようなメソッドは厳密に言うと「クラスオブジェクトの特異メソッド」を定義していることになる

# 定数
# クラスの中には定数を定義することもできる。
class Product
  # デフォルトの価格を定数として定義する
  DEFAULT_PRICE = 0

  attr_reader :name, :price

  def initialize(name, price = DEFAULT_PRICE)
    @name = name
    @price = price
  end
end

product = Product.new('A free movie')
product.price # => 0

# 定数は必ず大文字で始める必要がある。慣習的にアルファベットの大文字と数字、それにアンダースコアで構成されることが多い
# 定数名の例
DEFAULT_PRICE = 0
UNITS = { m: 1.0, ft: 3.28, in: 39.37 }

# 定数はインスタンスメソッド内でもクラスメソッド内でも同じ方法で参照することができる
class Product
  DEFAULT_PRICE = 0

  def self.default_price
    # クラスメソッドから定数を参照する
    DEFAULT_PRICE
  end

  def default_price
    # インスタンスメソッドから定数を参照する
    DEFAULT_PRICE
  end
end

Priduct.default_price # => 0

product = Product.new
product.default_price # => 0