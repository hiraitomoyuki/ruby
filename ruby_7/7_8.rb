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