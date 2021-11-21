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