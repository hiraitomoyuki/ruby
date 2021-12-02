# publicメソッド
# publicメソッドはクラスの外部からでも自由に呼び出せるメソッド。initializeメソッド以外のインスタンスメソッドはデフォルトでpublicメソッドになる
class User
  # デフォルトはpublic
  def hello
    'Hello!'
  end
end
user = User.new
# publicメソッドなのでクラスの外部から呼び出せる
user.hello # => "Hello!"

# privateメソッド
# 「クラスの外からは呼び出せず、クラスの内部でのみ使えるメソッド」
class User
  # ここから下で定義されたメソッドはprivate
  private

  def hello
    'Hello!'
  end
end
user = User.new
# privateメソッドなのでクラスの外部から呼び出せない
user.hello # => NoMethodError: private method 'hello' called for #<User:0x007fb18a3e9fc0>
# 厳密に言うとprivateメソッドは「レシーバを指定して呼び出すことができないメソッド」になる
# user.helloとかいた場合はuserがhelloメソッドのレシーバになる。しかし、helloメソッドがprivateメソッドであればレシーバを指定できないため、user.helloのように呼び出すとエラーになる
# 「privateメソッドはレシーバを指定できない」と言うルールはクラスの内部でも有効。「クラス内でほかのメソッドを呼び出す場合はselfをつけても良い」だが、privateメソッドではselfつきで呼び出すとエラーになる。selfというレシーバを指定してメソッドを呼び出すことになるため
class User
  def hello
    # nameメソッドはprivateなのでselfをつけるとエラーになる
    "Hello, I am #{self.name}."
  end

  private

  def name
    'Alice'
  end
end
user = User.new
user.hello # => NoMethodError: private method 'name' called for #<User:0x007fb18a3903d0>

# selfを省略するとエラーにはならない
class User
  def hello
    # selfなしでnameメソッドを呼び出す
    "Hello, I am #{name}."
  end

  private

  def name
    'Alice'
  end
end
user = User.new
user.hello # => "Hello, I am Alice."

# privateメソッドはサブクラスでも呼び出せる
# 他の言語では「privateメソッドはそのクラスの内部でのみ呼び出せる」というしようになっていることが多いが、Rubyでは「privateメソッドはそのクラスだけでなく、サブクラスでも呼び出せる」という仕様になっている
class Product
  private

  # これはprivateメソッド
  def name
    'A great movie'
  end
end

class DVD < Product
  def to_s
    # nameはスーパークラスのprivateメソッド
    "name: #{name}"
  end
end

dvd = DVD.new
# 内部でスーパークラスのprivateメソッドを呼んでいるがエラーにはならない
dvd.to_s # => "name: A great movie"

class Product
  def to_s
    # nameは常に"A great movie"になるとは限らない
    "name: #{name}"
  end

  private

  def name
    'A great movie'
  end
end

class DVD < Product
  private

  # スーパークラスのprivateメソッドをオーバーライドする
  def name
    'An awesome film'
  end
end

product = Product.new
# Productクラスのnameメソッドが使われる
product.to_s # => "name: A great movie"

dvd = DVD.new
# オーバーライドしたDVDクラスのnameメソッドが使われる
dvd.to_s     # => "name: An awesome film"

# 今回は意図的にnameメソッドをオーバーライドしたが、場合によっては意図せずに偶然スーパークラスのprivateメソッドをオーバーライドしてしまったということもありえる
# これはわかりにくい不具合の原因になるので、Rubyで継承を使う場合はスーパークラスの実装もしっかりと把握しないといけない

# クラスメソッドをprivateにしたい場合
# privateメソッドになるのはインスタンスメソッドのみ。クラスメソッドはprivateキーワードの下に定義してもprivateにはならない
class User
  private

  # クラスメソッドもprivateになる？
  def self.hello
    'Hello!'
  end
end
# クラスメソッドはprivateにならない
User.hello # => "Hello!"

# クラスメソッドをpraivateにしたい場合は、class << selfの構文を使う
class User
  class << self
    # class << selfの構文ならクラスメソッドでもprivateが機能する
    praivate

    def hello
      'Hello!'
    end
  end
end
User.hello # => NoMethodError: private method 'hello' called for User:Class

# class << selfを使わない場合は、private_class_methodでクラスメソッドを定義後に公開レベルを変更することができる
class User
  def self.hello
    'Hello!'
  end
  # 後からクラスメソッドをprivateに変更する
  private_class_method :hello
end
User.hello # => NoMethodError: private method 'hello' called for User:Class

# privateメソッドから先に定義する場合
# praivateキーワードの下に定義したメソッドがprivateメソッドになるように、publicキーワードの下に定義したメソッドはpublicメソッドになる。
# これを元にすると、privateメソッドやpublicメソッドを好きな順番で定義することができる
class User
  # ここから下はprivateメソッド
  private

  def foo
  end

  # ここから下はpublicメソッド
  public

  def bar
  end
end
# 通常はprivateキーワードを使うのは1回だけにして、クラスの最後の方にpraivateメソッドの定義をまとめることが多い

# 後からメソッドの公開レベルを変更する場合
# privateキーワードは実際にはメソッドなので、引数を渡すことができる。既存のメソッド名wpprivateキーワード(privateメソッド)に渡すと、そのメソッドがprivateメソッドになる。また、引数を渡した場合はその下に定義したメソッドの公開レベルは変更されない
class User
  # いったんpublicメソッドとして定義する
  def foo
    'foo'
  end

  def bar
    'bar'
  end

  # fooとbarをprivateメソッドに変更する
  private :foo, :bar

  # bazはpublicメソッド
  def baz
    'baz'
  end
end

user = User.new
user.foo # => NoMethodError: private method 'foo' called for #<User:0x007fea4d08e118>
user.bar # => NoMethodError: private method 'foo' called for #<User:0x007fea4d08e118>
user.baz # => "baz"

# protectedメソッド
# protectedメソッドはそのメソッドを定義したクラス自身と、そのサブクラスのインスタンスメソッドからレシーバ付きで呼び出せる
# Rubyの場合、「そのクラス自身とサブクラスから呼び出せる」だけではprivateメソッドと違いがないので「レシーバ付きで」が大切
class User
  # weightは外部に公開しない
  attr_reader :name

  def initialize(name, weight)
    @name = name
    @weight = weight
  end
end
# 何らかの理由でユーザ同士の体重を比較しなければならなくなった
class User
  # 省略

  # 自分がother_userより重い場合はtrue
  def heavier_than?(other_user)
    other_user.weight < @weight
  end
end
# このままだとother_userの体重(weight)は取得できないのでエラーになる
alice = User.new('Alice', 50)
bob = User.new('Bob', 60)
# AliceはBobのweightを取得できない
alice.heavier_than?(bob)
# => NoMethodError: undefined method 'weight' for #<User:0x007fbb2381c55...

# weightをpublicメソッドとして公開してしまうとother_userの体重を取得できるが、一方で自分の体重も外部から取得可能になってしまう。かといってprivateメソッドにすると、レシーバ付きで呼び出せないので、other_user.weightのような形式で呼び出そうとするとエラーになる
# 外部には公開したくないが、同じクラスやサブクラスの中であればレシーバ付きで呼び出せるようにしたい、というときに登場するのがprotectedメソッド。weightメソッドをprotectedメソッドにする
class User
  # 省略

  def heavier_than?(other_user)
    other_user.weight < @weight
  end

  protected

  # protectedメソッドのなので同じクラスかサブクラスであればレシーバ付きで呼び出せる
  def weight
    @weight
  end
end
alice = User.new('Alice', 50)
bob = User.new('Bob', 60)

# 同じクラスのインスタンスメソッド内であればweightが呼びっ出せる
alice.heavier_than?(bob) # => false
bob.heavier_than?(alice) # => true

# クラスの外ではweightは呼び出せない
alice.weight # => NoMethodError: protected method 'weight' called for #<User:0x007fb24001ba8...
# 体重の一般公開を避けつつ、仲間(同じクラス)の中でのみ、ほかのオブジェクトに公開することができた
# なお、単純なゲッターメソッドであれば、次のようにしてweightメソッドだけをあとからprotectedメソッドに変更した方がシンプルかも
class User
  # いったんpublicメソッドとしてweightを定義する
  attr_reader :name, :weight
  # weightのみ、あとからprotectedメソッドに変更する
  protected :weight

  # 省略
end
# とはいえ、publicメソッドとprivateメソッドに比べるとprotectedメソッドが登場する機会はずっと少ない
