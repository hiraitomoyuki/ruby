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