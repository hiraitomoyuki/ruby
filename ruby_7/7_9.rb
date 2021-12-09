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

# クラス変数
# クラスインスタンス変数はインスタンスメソッド内で共有されることがなく、スーパークラスとサブクラスでも共有されることがない
# 一方で、Eubyにはクラスメソッド内でもインスタンスメソッド内でも共有され、なおかつスーパークラスとサブクラスでも共有される変数も存在する。それがクラス変数。クラス変数は@@some_valueのように、変数名の最初に@を2つ重ねる
class Product
  @@name = 'Product'

  def self.name
    @@name
  end

  def initialize(name)
    @@name = name
  end

  def name
    @@name
  end
end

class DVD < Product
  @@name = 'DVD'

  def self.name
    @@name
  end

  def upcase_name
    @@name.upcase
  end
end

# DVDクラスを定義したタイミングで@@nameが"DVD"に変更される
Product.name # => "DVD"
DVD.name     # => "DVD"

product = Product.new('A great movie')
product.name # => "A great movie"

# Product.newのタイミングで@@nameが"A great movie"に変更される
Product.name # => "A great movie"
DVD.name     # => "A great movie"

dvd = DVD.new('An awesome film')
dvd.name        # => "An awesome film"
dvd.upcase_name # => "AN AWESOME FILM"

# DVD.newのタイミングで@@nameが"An awesome film"に変更される
product.name # => "An awesome film"
Product.name # => "An awesome film"
DVD.name     # => "An awesome film"

# コードや実行結果がちょっと長いのですぐには理解しにくいが、クラス変数の@@nameはクラスメソッド内でもインスタンスメソッド内でも共有されている。またスーパークラスとサブクラスの間でも共有されている。そのため、@@nameの内容が変更されるとほかのクラスやほかのインスタンスのメソッドも実行結果が変わっている。
# クラス変数は小さなプログラムでは必要になることは少ないが、ライブラリ(gem)の設定情報(config値)を格納する場合などに使われることがある

# グローバル変数と組み込み変数
# Rubyにはもう1種類、グローバル変数というタイプの変数がある。グローバル変数は$some_valueのように、$で変数名を始める。グローバル変数はクラスの内部、外部問わず、プログラムのどこからでも変更、参照が可能
# グローバル変数の宣言と値の代入
$program_name = 'Awesome program'

# グローバル変数に依存するクラス
class Program
  def initialize(name)
    $program_name = name
  end

  def self.name
    $program_name
  end

  def name
    $program_name
  end
end

# $program_nameにはすでに名前が代入されている
Program.name # => "Awesome program"

program = Program.new('Super program')
program.name # => "Super program"

# Program.newのタイミングで$program_nameが"Super program"に変更される
Program.name  # => "Super program"
$program_name # => "Super program"

# ただし、グローバル変数の乱用は理解しづらいプログラムの原因になる。何か特別な理由がない限り、グローバル変数に依存するようなプログラムを書くことは避けるべき。
# また、$で始まるいくつかの変数は「組み込み変数」や「特殊変数」として、Ruby自身によって最初から用途を決められている。例えば、正規表現の実行結果を格納する$&1や$1など。正規表現以外でも$stdinや$*など、$で始まる変数が最初から用意されている。
# とはいえ、$で始まる組み込み変数や特殊変数は別の方法でも同じ情報を取得できることが多い。組み込み変数や特殊変数を多用すると記号の意味を知っている人しか理解できないコードになってしまうので、極力組み込み変数の使用は避け、他の人が理解しやすいコードを書くことを心がける。