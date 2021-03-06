class User
end
# このクラスにはメソッドを何一つ定義していないが、Userクラスのオブジェクトはto_sメソッドやnil?メソッドを呼び出すことができる
user = User.new
user.to_s # => "#<User:0x007f8f9286d598>"
user.nil? # => false
# これはUserクラスがObjectクラスを継承しているため。
user.superclass # => Object

user = User.new
user.methods.sort # => [:!, :!=, :!~, :<=>, :==, (省略) :untrust, :untrusted?]

# オブジェクトのクラスを確認する
# オブジェクトのクラスを調べる場合はclassメソッドを使う
user = User.new
user.class # => User

# instance_of?メソッドを使って調べることもできる
user = User.new

# userはUserクラスのインスタンスか？
user.instance_of?(User)   # => true

# userはStringクラスのインスタンスか？
user.instance_of?(String) # => false

# 継承関係(is-a関係にあるかどうか)を含めて確認したい場合はis_a?メソッド(エイリアスメソッドはkind_of?)を使う
user = User.new

# instance_of?はクラスが全く同じでないとtrueにならない
user.instance_of?(Object) # => false

# is_a?はis-a関係にあればtrueになる
user.is_a(User)        # => true
user.is_a(Object)      # => true
user.is_a(BasicObject) # => true

# is-a関係にない場合はfalse
user.is_a?(String)     # => false

# 他のクラスを継承したクラスを作る
# 独自のクラスを定義する際はObjectクラス以外のクラスを継承することもできる
class サブクラス < スーパークラス
end
# DVDクラスはProductクラスを継承する
class DVD < product
end

# superでスーパークラスのメソッドを呼び出す
class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
product = Product.new('A great movie', 1000)
product.name  # => "A great movie"
product.price # => 1000

class DVD < Product
  # nameとpriceはスーパークラスでattr_readerが設定されているので定義不要
  attr_reader :running_time

  def initialize(name, price, running_time)
    # スーパークラスにも存在している属性
    @name = name
    @price = price
    # DVDクラス独自の属性
    @running_time = running_time
  end
end
dvd = DVD.new('A great movie', 1000, 120)
dvd.name         # => "A great movie"
dvd.price        # => 1000
dvd.running_time # => 120

# nameとpriceについては、スーパークラスのinitializeメソッドでも同じように値を代入している。全く同じ処理を繰り返し書くぐらいならスーパークラスの処理を読んだ方がシンプル。
class DVD < Product
  attr_reader :running_time

  def initialize(name, price, running_time)
    # スーパークラスのinitializeメソッドを呼び出す
    super(name, price)
    @running_time = running_time
  end
end
dvd = DVD.new('A great movie', 1000, 120)
dvd.name         # => "A great movie"
dvd.price        # => 1000
dvd.running_time # => 120

# もし仮に、スーパークラスとサブクラスで引数の数が同じだった場合は、引数なしのsuperを呼ぶだけで自分に渡された引数を全てスーパークラスに引き渡すことができる
class DVD < Product
  def initialize(name, price)
    # 引数を全てスーパークラスのメソッドに渡す。つまりsuper(name, price)と書いたのと同じ
    super

    # サブクラスで必要な初期化処理を書く
  end
end
dvd = DVD.new('A great movie', 1000)
dvd.name         # => "A great movie"
dvd.price        # => 1000

# ただし、super()と書いた場合は「引数0個でスーパークラスの同名メソッドを呼び出す」の意味になるので注意
class DVD < Product
  def initialize(name, price)
    # super()だと引数なしでスーパークラスのメソッドを呼び出す
    # (ただし数が合わないのでこのコードではエラーになる)
    super()
  end
end
# スーパークラスのinitializeメソッドを引数0個で呼び出そうとするのでエラーになる
dvd = DVD.new('A great movie', 1000)
# => ArgumentError: wrong number of arguments (given 0, expected 2)

# そもそもスーパークラスとサブクラスで実行する処理が変わらなければ、サブクラスで同名メソッドを定義したりsuperを読んだりする必要はない
class DVD < Product
  def initialize(name, price)
    # サブクラスで特別な処理をしないなら、同名メソッドを定義する必要はない
    # (スーパークラスに処理を任せる)
    # def initialize(name, price)
    #   super
    # end
end
# DVDクラスをnewすると、自動的にスーパークラスのinitializeメソッドが呼び出される
dvd = DVD.new('A great movie', 1000)
dvd.name         # => "A great movie"
dvd.price        # => 1000

# ここではinitializeメソッドでsuperを使ったが、initializeメソッド以外のメソッドでも同じようにsuperを使うことができる

# メソッドのオーバーライド
# サブクラスではスーパークラスと同名のメソッドを定義することで、スーパークラスの処理を上書きすることができる。これをメソッドのオーバーライドと言う。
# 先ほどのDVDクラスのinitializeメソッドもオーバーライドの一種だが、initialize以外のメソッドを使ってオーバーライドの仕組みを理解する
# ここではto_sメソッドを使う。to_sメソッドはオブジェクトの内容を文字列に変換して返すメソッド。
# このメソッドはObjectクラスで(=事実上の頂点クラス)で定義されているので、すべてのオブジェクトでto_sメソッドを呼び出すことができる。
# つまり、自分で作ったProductクラスやDVDクラスでもto_sメソッドを呼び出すことができる
class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

class DVD < Product
  attr_reader :running_time

  def initialize(name, price, running_time)
    super(name, price)
    @running_time = running_time
  end
end

product = Product.new('A great movie', 1000)
product.to_s # => "#<Product:0x007fe4e42e9f20>"

dvd.to_s     # => "#<DVD:0x007fe4e42c2830>"

# to_sメソッドは呼び出せるが、もう少しわかりやすい文字列が返ってくるようにProductクラスでto_sメソッドをオーバーライドしてみる
class Product
  # 省略

  def to_s
    "name: #{name}, price: #{price}"
  end
end

product = Product.new('A great movie', 1000)
product.to_s # => "name: A great movie, price: 1000"

dvd = DVD.new('An awesome film', 3000, 120)
dvd.to_s     # => "name: An awesome film, price: 3000"

# これではDVDクラスで再生時間(running_time)が表示されていない。再生時間も表示されるように、DVDクラスでもto_sメソッドをオーバーライドすることにする
class DVD < Product
  # 省略

  def to_s
    "name: #{name}, price: #{price}, running_time: #{running_time}"
  end
end

dvd = DVD.new('An awesome film', 3000, 120)
dvd.to_s # => "name: An awesome film, price: 3000, running_time: 120"

# これで再生時間も表示されるようになった。ただし、商品名と価格の表示はスーパークラスと同じなので、この部分はスーパークラスのメソッドを呼び出した方がシンプル。superを使ってスーパークラスのメソッドを活用する
class DVD < Product
  # 省略

  def to_s
    # superでスーパークラスのto_sメソッドを呼び出す
    "#{super}, running_time: #{running_time}"
  end
end

dvd = DVD.new('An awesome film', 3000, 120)
dvd.to_s # => "name: An awesome film, price: 3000, running_time: 120"

# クラスメソッドの継承
# クラスを継承すると、クラスメソッドも継承される
class Foo
  def self.hello
    'hello'
  end
end

class Bar < Foo
end

# Fooを継承したBarでもクラスメソッドのhelloが呼び出される
Foo.hello # => "hello"
Bar.hello # => "hello"

# ただし、インスタンスメソッドに比べると、継承されたクラスメソッドを活用する機会はあまりない
