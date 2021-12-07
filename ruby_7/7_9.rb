# さまざまな種類の変数
・クラスインスタンス変数
・クラス変数
・グローバル変数
・Ruby標準の組み込み変数(特殊変数)
# があるが、使用頻度は少ない

# クラスインスタンス変数

class Product
  @name = 'Product'

  def self.name
    @name
  end

  def initialize(name)
    @name = name
  end

  # attr_reader :nameでもいいが、@nameの中身を意識するためにあえてメソッドを定義する
  def name
    @name
  end
end

Product.name # => "Product"

product = Product.new('A great movie')
product.name # => "A great movie"
Product.name # => "Product"

# 上のコードには@nameが4箇所登場しているが、実は2種類の@nameに分かれる。1つはインスタンス変数の@nameで、もうひとつはクラスインスタンス変数の@name。見た目は同じだが、全く別のデータ。
class Product
  # クラスインスタンス変数
  @name = 'Product'

  def self.name
    # クラスインスタンス変数
    @name
  end

  def initialize(name)
    # インスタンス変数
    @name = name
  end

  def name
    # インスタンス変数
    @name
  end
end

# インスタンス変数はクラスをインスタンスか(クラス名.newでオブジェクトを作成)した際に、オブジェクトごとに管理される変数。
# 一方、クラスインスタンス変数はインスタンスの作成とは無関係に、クラス自身が保持しているデータ(クラス自身のインスタンス変数)。クラス構文の直下や、クラスメソッドの内部で@で始まる変数を操作すると、クラスインスタンス変数にアクセスしていることになる。
# ここに継承の考え方が入るとさらにややこしくなる
class Product
  # 省略
end

class DVD < Product
  @name = 'DVD'

  def self.name
    # クラスインスタンス変数を参照
    @name
  end

  def upcase_name
    # インスタンス変数を参照
    @name.upcase
  end
end

Product.name    # => "Product"
DVD.name        # => "DVD"

product = Product.new('A great movie')
product.name    # => "A great movie"

dvd = DVD.new('An awesome film')
dvd.name        # => "An awesome film"
dvd.upcase_name # => "AN AWESOME FILM"

Product.name    # => "Product"
DVD.name        # => "DVD"

# DVDクラスはProductクラスを継承している。インスタンス変数の@nameはスーパークラス内で参照しても、サブクラス内で参照しても同じ値になる。例えば、上記でいうと、@name.upcaseの@nameには文字列の"An awesome film"が入っている
# 一方、クラスインスタンス変数ではProductクラスとDVDクラスで別々に管理されている。上記でいうと、Productクラスの@nameには文字列の"Product"が、DVDクラスの@nameには文字列の"DVD"が入っている。
# インスタンス変数の継承関係に応じてスーパークラスとサブクラスで変数の内容が共有されるが、クラスインスタンス変数はスーパークラスとサブクラスでそれぞれ別々に内容が管理されている。
# インスタンス変数に比べるとクラスインスタンス変数を使う機会は少ないと思うが、クラス自身もインスタンス変数を保持できることと、インスタンス変数とは異なりスーパークラスとサブクラスでは同じ名前でも別の変数になる