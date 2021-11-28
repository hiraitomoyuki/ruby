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