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

# 等値を判断するメソッドや演算子を理解する
# if文などで同じ値かどうか比較する場合は==を使うことが多いが、Rubyでは等値を判断するためのメソッドや演算子がほかにもある。
equal?
==
eql?
===
# equal?メソッド以外は要件に合わせて再定義することが可能。

# equal?
# equal?メソッドはobject_idが等しい場合にtrueを返す。つまり全く同じインスタンスかどうかを判断する場合に使う。この挙動が変わるとプログラムの実行に悪影響を及ぼす恐れがあるため、equal?メソッドは再定義してはいけない
a = 'abc'
b = 'abc'
a.equal?(b) # => false

c = a
a.equal?(c) # => true

# ==
# ==はオブジェクトの内容が等しいかどうかを判断する。1 == 1.0がtrueになるように、データ型が違っても人間の目で見て自然であればtrueを返すように再定義することがある。
1 == 1.0 # => true

# eql?
# eql?メソッドはハッシュのキーとして2つのオブジェクトが等しいかどうかを判断する。==の結果をそのまま返せば十分なケースが多いが、==では等値と見なしてもハッシュのキーとしては異なる値として扱いたい場合は、eql?メソッドにその要件を定義する
# たとえば、Rubyの標準クラスでいうと、1 == 1.0はtrueであっても、1と1.0を異なるキーとして扱う。これは1.eql?(1.0)がfalseを返すように定義されているため
# ハッシュ上では1と1.0は別々のキーとして扱われる
h = { 1 => 'Integer', 1.0 => 'Float' }
h[1] # => "Integer"
h[1.0] # => "Float"

# 異なるキーとして扱われるのは、eql?メソッドで比較したときにfalseになるため
1.eql?(1.0) # => false

# なお、eql?メソッドを再定義した場合は、「a.eql?(b)が真なら、a.hash == b.hashも真」となるようにhashメソッドも再定義しなければならない
a = 'japan'
b = 'japan'
# eql?が真なら、hashも同じ
a.eql?(b) # => true
a.hash    # => 1168978237820510471
b.hash    # => 1168978237820510471

c = 1
b = 1.0
# eql?が偽なら、hash値も異なる
c.eql?(d) # => false
c.hash    # => -2946966815421412510
d.hash    # => 3646131212290672247