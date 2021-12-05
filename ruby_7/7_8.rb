# 定数についてもっと詳しく
# 定数はクラスの外部から直接参照することも可能です。クラスの外部から定数を参照する場合は
クラス名::定数名

class Product
  DEFAULT_PRICE = 0
end

Product::DEFAULT_PRICE # => 0

# 定数をクラスの外部から参照させたくない場合はprivate_constantで定数名を指定する。Rubyの場合は何か特別な理由がない限りわざわざprivateにすることは少ない
class Product
  DEFAULT_PRICE = 0

  # 定数をprivateにする
  private_constant :DEFAULT_PRICE
end

# privateなのでクラスなのでクラスの外部からは参照できない
Product::DEFAULT_PRICE # => NoNameError: pravate constant Product::DEFAULT_PRICE rederenced

# 定数はメソッドの内部で作成することはできない。必ずクラス構文の直下で作成する必要がある
class Product
  def foo
    # メソッドの内部で定数を作成すると構文エラーになる
    DEFAULT_PRICE = 0
  end
end
# => SyntaxError: dynamic constant assignment
#        DEFAULT_PRICE = 0
#                       ^

# 定数と再代入
# Rubyの定数は「みんな、わざわざ変更するなよ」と周りに念を押した変数のようなもの。そのままの状態では定数を色々と変更できてしまう
# まず、定数には再代入が可能。なので、定数の値を後から書き換えることができる。
class Product
  DEFAULT_PRICE = 0
  # 再代入して定数の値を書き換える
  DEFAULT_PRICE = 1000
end
# => warning: already initialized constant Product::DEFAULT_PRICE

# 再代入後の値が返る
Product::DEFAULT_PRICE # => 1000

# クラスの外部からでも再代入が可能
Product::DEFAULT_PRICE = 3000
# => warning: already initialized constant Product::DEFAULT_PRICE

Product::DEFAULT_PRICE # => 3000
# 「定数はすでに初期化済みである(already initialized constant)」と警告は表示されるが、再代入自体は成功する
# クラスの外部からの再代入を防ぎたい場合はクラスをfreeze(凍結)にする。こうするとクラスは変更を受け付けなくなる

# クラスを凍結する
Product.freeze

# freezeすると変更できなくなる
Product::DEFAULT_PRICE = 5000 # => RuntimeError: can't modeify frozen #<Class:Product>
# だが、Rubyの場合、普通は定数を上書きする人はいないだとうということで、わざわざクラスをfreezeさせることは少ない。同様にクラス内でもfreezeを呼べば再代入を防ぐことができるが、そのあとでメソッドの定義もできなくなってしまうので、freezeを呼ぶことはまずない。
class Product
  DEFAULT_PRICE = 0
  # freezeすれば再代入を防止できるが、デメリットの方が大きいので普通はしない
  freeze
  DEFAULT_PRICE = 1000 # => RuntimeError: can't modify frozen #<Class:Product>
end

# 定数はミュータブルなオブジェクトに注意する
# 再代入をしなくてもミュータブルなオブジェクトであれば定数の値を変えることができる。ミュータブルなオブジェクトとは、例えば文字列やハッシュなど。
# 定数の値を破壊的に変更してしまうコード例
class Product
  NAME = 'A product'
  SOME_NAMES = ['Foo', 'Bar', 'Baz']
  SOME_PRICES = { 'Foo' => 1000, 'Bar' => 2000, 'Baz' => 3000 }
end

# 文字列を破壊的に大文字に変更する
Product::NAME.upcase!
Product::NAME # => "A PRODUCT"

# 配列に新しい要素を追加する
Product::SOME_NAMES << 'Hoge'
Product::SOME_NAMES # => ["Foo", "Bar", "Baz", "Hoge"]

# ハッシュに新しいキーと値を追加する
Product::SOME_PRICES['Hoge'] = 4000
Product::SOME_PRICES # => {"Foo"=>1000, "Bar"=>2000, "Baz"=>3000, "Hoge"=>4000}

# 定数の中身が変更されてしまった。上のコードは定数を直接変更しているので見た目にも「定数を変更している」ということが明らかだが、定数の値を変数に代入してしまうと定数を変更していることに気づきにくい
class Product
  SOME_NAMES = ['Foo', 'Bar', 'Baz']
  def self.names_without_foo(names = SOME_NAMES)
    # nameがデフォルト値だと、以下のコードは定数のSOME_NAMESを破壊的に変更していることになる
    names.delete('Foo')
    names
  end
end

Product.names_without_foo # => ["Bar", "Baz"]

# 定数の中身が変わってしまった！
Product::SOME_NAMES       # => ["Bar", "Baz"]

# こうした事故を防ぐためには、定数の値をfreezeする。こうすると定数に対して破壊的な変更ができなくなる
class Product
  # 配列を凍結する
  SOME_NAMES = ['Foo', 'Bar', 'Baz'].freeze

  def self.names_without_foo(names = SOME_NAMES)
    # freezeしている配列に対しては破壊的な変更はできない
    names.delete('Foo')
    names
  end
end

# エラーが発生するのでうっかり定数の値が変更される事故が防げる
Product.names_without_foo # => RuntimeError: can't modify frozen Array

# これでもまだ完璧ではない。配列やハッシュをfreezeすると配列やハッシュそのものへの変更は防止できますが、配列やハッシュの各要素はfreezeしない。よって、次のようなコードを書くと定数の内容はやはり変更されてしまう
class Product
  # 配列はfreezeされるが中身の文字列はfreezeされない
  SOME_NAMES = ['Foo', 'Bar', 'Baz'].freeze
end
# 1番目の要素を破壊的に大文字に変更する
Product::SOME_NAMES[0].upcase!
# 1番目の要素の値が変わってしまった！
Product::SOME_NAMES # => ["FOO", "Bar", "Baz"]

# この事故も防ぎたいとなると、各要素の値を別途freezeする必要がある
class Product
  # 中身の文字列もfreezeする
  SOME_NAMES = ['Foo'.freeze, 'Bar'.freeze, 'Baz'.freeze].freeze
end
# 今度は中身もfreezeしているので破壊的な変更はできない
Product::SOME_NAMES[0].upcase! # => RuttimeError: can't modify frozen String

# なお、次のようにmapメソッドを使うと、freezeを何度も書かずに済む。

# mapメソッドで各要素をfreezeし、最後にmapメソッドの戻り値の配列をfreezeする
SOME_NAMES = ['Foo', 'Bar', 'Baz'].map(&:freeze).freeze

# 配列やハッシュの中身まで全てfreezeするのは少し大変かもしれない。プログラムの規模や要件(堅牢性がどこまで重視されるかなど)に応じて、freezeを適用するレベル(深さ)を検討する
# 一方、イミュータブルなオブジェクトはfreezeする必要がないことも押さえておく。数値やシンボル、true/falseなどはイミュータブルなオブジェクトなので破壊的に変更することはできない
class Product
  # 数値やシンボル、true/falseはfreeze不要(してもかまわないが、意味がない)
  SOME_VALUE = 0
  SOME_TYPE = :foo
  SOME_FLAG = true
end

# Rubyの定数は「絶対変更できない値」ではなく、むしろ定数であっても「変更しようと思えばいくらでも変更できる値」になっている。定数にしておいたから大丈夫だと思い込まず、「ついうっかり」の事故を防ぐためには幾らかの工夫が必要になることを覚えておく。