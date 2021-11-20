# selfキーワード
# Rubyにはインスタンス自身を表すselfキーワードがある。JavaやC#であれば、thisキーワードとほぼ同じ
# メソッドの内部で他のメソッドを呼び出す場合は暗黙的にselfに対してメソッドを呼び出している。そのため、selfは省略可能だが、明示的にselfをつけてメソッドを呼び出しても大丈夫
class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def hello
    # selfなしでnameメソッドを呼ぶ
    "Hello, I am #{name}."
  end

  def hi
    # selfつきでnameメソッドを呼ぶ
    "Hi, I am #{self.name}."
  end

  def my_name
    # 直接インスタンス変数の@nameにアクセスする
    "My name is #{@name}."
  end
end
user = User.new('Alice')
user.hello   # => "Hello, I am Alice"
user.hi      # => "Hi, I am Alice."
user.my_name # => "My name is Alice."

# 上記の通り、nameもself.nameも@nameも同じ文字列"Alice"を返す。

# selfのつけ忘れで不具合が発生するケース
# 値をセットするname=メソッドの場合は話が異なる
class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename_to_bob
    # selfなしでname=メソッドを呼ぶ(?)
    name = 'Bob'
  end

  def rename_to_carol
    # selfつきでname=メソッドを呼ぶ
    self.name = 'Carol'
  end

  def rename_to_dave
    # 直接インスタンス変数を書き換える
    @name = 'Dave'
  end
end
user = User.new('Alice')

# Bobにリネーム…できていない！！
user.rename_to_bob
uesr.name # => "Alice"

# Carolにリネーム
user.rename_to_carol
user.name # => "Carol"

# daveにリネーム
user.rename_to_dave
user.name # => "Dave"

# rename_to_bobメソッドだけリネームがちゃんとできず、"Alice"のままになっている
# このコードを実行すると、「nameというローカル変数に"Bob"という文字列を代入した」と解釈されてしまう
# 構文だけ見るとローカル変数の代入と全く同じ形
# なので、name=のようなセッターメソッドを呼び出したい場合は、必ずselfをつける必要がある
def rename_to_bob
  # メソッド内でセッターメソッドを呼び出す場合はselfを必ずつける
  self.name = 'Bob'
end

# クラスメソッドやクラス構文直下のself

# クラス定義内に登場するselfは場所によって「そのクラスのインスタンス自身」を表したり、「クラス自身」を表したりする
class Foo
  # 注:このputsはクラス定義の読み込み時に呼び出される
  puts "クラス構文の直下のself: #{self}"

  def self.bar
    puts "クラスメソッド内のself: #{self}"
  end

  def baz
    puts "インスタンスメソッド内のself: #{self}"
  end
end
# => クラス構文の直下のself: Foo

Foo.bar # => クラスメソッド内のself: Foo

foo = Foo.new
foo.baz # => インスタンスメソッド内のself: #<Foo:0x007f9d7c0467c8>

# クラス構文の直下とクラスメソッド内でのselfはFooと表示されている。このFooは「Fooクラス自身」を表している。一方、インスタンスメソッド内でのselfは#<Foo:0x007f9d7c0467c8>と表示されている。これは「Fooクラスのインスタンス」を表している
# よって、次のようなエラーになる
class Foo
  def self.bar
    # クラスメソッドからインスタンスメソッドを呼び出す(エラー)
    self.bar
  end

  def baz
    # インスタンスメソッドからクラスメソッドを呼び出す(エラー)
    self.bar
  end
end

Foo.bar # => NoMethodError: undefined method 'baz' for Foo:Class

foo = Foo.new
foo.baz # => NoMethodError: undefined method 'bar' for #<Foo:0x007fdffc094070>

# これはselfを省略して呼び出した場合も同じ
# ちなみに、クラス構文直下ではクラスメソッドを呼び出すことができる。なぜなら、selfがどちらも「クラス自身」になるから。ただし、この場合でもクラスメソッドを定義した後、つまりクラスメソッド定義よりも下側でメソッドを呼び出す必要がある
class Foo
  # この時点ではクラスメソッドbarが定義されていないので呼び出せない
  # (NoMethodErrorが発生する)
  # self.bar

  def self.bar
    puts 'hello'
  end

  # クラス構文の直下でクラスメソッドを呼び出す
  # (クラスメソッドbarが定義された後なので呼び出せる)
  self.bar
end
# => hello

# Rubyの場合、クラス定義自体も上から順番に実行されるプログラムになっているので、クラス構文の直下でクラスメソッドを呼び出すこともできる。極端だが、クラス構文の直下に繰り返し処理のような普通のコードを書いても実行可能
class Foo
  # クラス定義が読み込まれたタイミングで"Hello!"を3回出力する
  3.times do
    puts 'Hello!'
  end
end
# => "Hello!"
#    "Hello!"
#    "Hello!"

# クラスメソッドをインスタンスメソッドで呼び出す
# クラスメソッドをインスタンスメソッドの内部から呼び出す場合
クラス名.メソッド

class Product
  attr_render :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  # 金額を整形するクラスメソッド
  def self.format_price(price)
    "#{price}円"
  end

  def to_s
    # インスタンスメソッドからクラスメソッドを呼び出す
    formatted_price = Product.format_price(price)
    "name: #{name}, price: #{formatted_price}"
  end
end

product = Product.new('A great movie', 1000)
product.to_s # => "name: A great movie, price: 1000円"

# "クラス名.メソッド"とかく代わりに、"self.class.メソッド"のように書く場合もある。
# クラス名.メソッドの形式でクラスメソッドを呼び出す
Product.format_price(price)

# self.class.メソッドの形式でクラスメソッドを呼び出す
self.class.format_price(price)