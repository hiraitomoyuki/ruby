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