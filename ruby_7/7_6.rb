class User
end
# このクラスにはメソッドを何一つ定義していないが、Userクラスのオブジェクトはto_sメソッドやnil?メソッドを呼び出すことができる
user = User.new
user.to_s # => "#<User:0x007f8f9286d598>"
user.nil? # => false
# これはUserクラスがObjectクラスを継承しているため。
user.superclass # => Object

user = User.new
user.methods.sort # => [:!, :!=, :!~, :<=>, :==, (省略) :untrust, :untrusted?]

# オブジェクトのクラスを確認する
# オブジェクトのクラスを調べる場合はclassメソッドを使う
user = User.new
user.class # => User

# instance_of?メソッドを使って調べることもできる
user = User.new

# userはUserクラスのインスタンスか？
user.instance_of?(User)   # => true

# userはStringクラスのインスタンスか？
user.instance_of?(String) # => false

# 継承関係(is-a関係にあるかどうか)を含めて確認したい場合はis_a?メソッド(エイリアスメソッドはkind_of?)を使う
user = User.new

# instance_of?はクラスが全く同じでないとtrueにならない
user.instance_of?(Object) # => false

# is_a?はis-a関係にあればtrueになる
user.is_a(User)        # => true
user.is_a(Object)      # => true
user.is_a(BasicObject) # => true

# is-a関係にない場合はfalse
user.is_a?(String)     # => false