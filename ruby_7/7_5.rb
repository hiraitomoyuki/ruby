# selfキーワード
# Rubyにはインスタンス自身を表すselfキーワードがある。JavaやC#であれば、thisキーワードとほぼ同じ
# メソッドの内部で他のメソッドを呼び出す場合は暗黙的にselfに対してメソッドを呼び出している。そのため、selfは省略可能だが、明示的にselfをつけてメソッドを呼び出しても大丈夫
class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def hello
    # selfなしでnameメソッドを呼ぶ
    "Hello, I am #{name}."
  end

  def hi
    # selfつきでnameメソッドを呼ぶ
    "Hi, I am #{self.name}."
  end

  def my_name
    # 直接インスタンス変数の@nameにアクセスする
    "My name is #{@name}."
  end
end
user = User.new('Alice')
user.hello   # => "Hello, I am Alice"
user.hi      # => "Hi, I am Alice."
user.my_name # => "My name is Alice."

# 上記の通り、nameもself.nameも@nameも同じ文字列"Alice"を返す。