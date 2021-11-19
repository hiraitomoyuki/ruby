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

# selfのつけ忘れで不具合が発生するケース
# 値をセットするname=メソッドの場合は話が異なる
class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename_to_bob
    # selfなしでname=メソッドを呼ぶ(?)
    name = 'Bob'
  end

  def rename_to_carol
    # selfつきでname=メソッドを呼ぶ
    self.name = 'Carol'
  end

  def rename_to_dave
    # 直接インスタンス変数を書き換える
    @name = 'Dave'
  end
end
user = User.new('Alice')

# Bobにリネーム…できていない！！
user.rename_to_bob
uesr.name # => "Alice"

# Carolにリネーム
user.rename_to_carol
user.name # => "Carol"

# daveにリネーム
user.rename_to_dave
user.name # => "Dave"

# rename_to_bobメソッドだけリネームがちゃんとできず、"Alice"のままになっている
# このコードを実行すると、「nameというローカル変数に"Bob"という文字列を代入した」と解釈されてしまう
# 構文だけ見るとローカル変数の代入と全く同じ形
# なので、name=のようなセッターメソッドを呼び出したい場合は、必ずselfをつける必要がある
def rename_to_bob
  # メソッド内でセッターメソッドを呼び出す場合はselfを必ずつける
  self.name = 'Bob'
end