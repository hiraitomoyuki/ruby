# エイリアスメソッドの定義
# 独自に作成したクラスでもエイリアスメソッドを定義することができる。エイリアスメソッドを定義する場合は、次のようにしてaliasキーワードを使う
alias 新しい名前 元の名前
# エイリアスメソッドを定義する場合はaliasキーワードを呼び出すタイミングに注意が必要。aliasキーワードを呼び出す場合は先に元のメソッドを定義しておかないとエラーになる。
# helloメソッドのエイリアスメソッドとしてgreetingメソッドを定義する例
class User
  def hello
    'Hello!'
  end

  # helloメソッドのエイリアスメソッドとしてgreetingを定義する
  alias greeting hello
end

user = User.new
user.hello    # => "Hello!"
user.greeting # => "Hello!"
# エイリアスは元のメソッドに新しい機能を追加する場合にもよく使われる。

# メソッドの削除
# 頻繁に使う機能ではないが、Rubyではメソッドの定数をあとから削除することもできる。メソッドを削除する場合はundefキーワードを使う
undef 削除するメソッドの名前

# スーパークラス(Objectクラス)で定義されているfreezeメソッドを削除するコード例
class User
  # freezeメソッドの定義を削除する
  undef freeze
end
user = User.new
# freezeメソッドを呼び出すとエラーになる
user.freeze # => NoMethodError: undefined method 'freeze' for #<User:0x007fea4d0c4d08>

# ネストしたクラスの定義
# クラス定義をする場合、クラスの内部に別のクラスを定義することもできる
class 外側のクラス
  class 内側のクラス
  end
end

# クラスの内部に定義したクラスは次のように::を使って参照できる
外側のクラス::内側のクラス

class User
  class BloodAType
    attr_reader :type

    def initialize(type)
      @type = type
    end
  end
end

blood_type = User::BloodType.new('B')
blood_type.type # => "B"

# こうした手法はクラス名の予期せぬ衝突を防ぐ「名前空間(ネームスペース)」を作る場合によく使われる。ただし、名前空間を作る場合はクラスよりもモジュールが使われることが多い。

# 演算子の挙動を独自に際定義する
# Rubyでは=で終わるメソッドを定義することができる。=で終わるメソッドは変数に代入するような形式で(正確には=の手前に空白を入れて)そのメソッドを呼ぶことができる。
class User
  # =で終わるメソッドを定義する
  def name=(value)
    @name = value
  end
end

user = User.new
# 変数に代入するような形式でname=メソッドを呼び出せる
user.name = 'Alice'

# Rubyでは一見演算子を使っているように見えて実際はメソッドとして定義されているものがあり、それらはクラスごとに再定義することができる。以下は再定義可能な演算子の一覧
| ^ & <=> == === =~ > >= < <= << >>
+ - * / % ** ~ +@ -@ [] []= '' ! != !~
# 上記の+@と-@は、-iのように正負を反転させたりするときに使う単項演算子。
# 一方、以下の演算子はRuby言語の制御構造に組み込まれているため、再定義できない
= ?: .. ... not && and || or ::
# 上の=はuser.nameのようにセッターメソッドとして使う=ではなく、user = xのように変数へ代入するときに使う=だ
# 例として==を再定義してみる。たとえば次のような商品(Product)クラスがあったとする
class Product
  attr_reader :code, :name

  def initialize(code, name)
    @code = code
    @name = name
  end
end

# codeは商品コードで、nameは商品名。商品コードはユニークな値が割り振られ、同じ商品コードであれば同じ商品だと判断する、という要件があったとする
# aとcが同じ商品コード
a = Product.new('A-0001', 'A great movie')
b = Product.new('B-0001', 'An awesome film')
c = Product.new('A-0001', 'A great movie')

# ==がこのように動作して欲しい
a == b # => false
a == c # => true

# しかし最初のコードのままだと、どちらも結果はfalseになる。なぜならスーパークラスのObjectクラスでは、==はobject_idが一致したときにtrueを返す、という仕様になっているから
# 何もしないと実際はこうなる
a == b # => false
a == c # => false

# デフォルトでは同じobject_id(全く同じインスタンス)の場合にtrueになる
a == a # => true

# というわけで、Productクラスで==を再定義(オーバーライド)する
class Product
  # 省略

  def ==(other)
    if other.is_a?(Product)
      # 商品コードが一致すれば同じProductとみなす
      code == other.code
    else
      # otherがProductでなければ常にfalse
      false
    end
  end
end
# こうすると==を使った比較が期待した通りに動作する
a = Product.new('A-0001', 'A great movie')
b = Product.new('B-0001', 'An awesome film')
c = Product.new('A-0001', 'A great movie')

# 商品コードが一致すればtrueになる
a == b # => false
a == c # => true

# Product以外の比較はflase
a == 1   # => false
a == 'a' # => false
# 少し奇妙な構文ですが、==はメソッドなので普通のメソッドのようにドット(.)付きで呼び出しても正常に動作する
a.==(b) # => false
a.==(c) # => true

# なお、==が呼び出されるのは左辺のオブジェクトになる。次のように書いた場合はProductクラスの==は呼び出されない
# 左辺にあるのが整数なので、Integerクラスの==が呼び出される
1 == a # => false

# 演算子を自分で再定義する機会はそれほど多くないかもしれないが、Rubyでは演算子や記号の類もメソッドとして再定義できる。