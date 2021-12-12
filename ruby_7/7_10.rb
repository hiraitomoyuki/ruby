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