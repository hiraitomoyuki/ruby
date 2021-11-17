# クラスの定義
# Rubyのクラスを定義する場合は
class クラス名
end
# クラス名は必ず大文字で始める。小文字で始めると構文エラーになる。慣習として、UserやOrderItemのようにキャメルケースで書くのが一般的
# Userクラスの定義
class User
end

# OrderItemクラスの定義
class OrderItem
end

# オブジェクトの作成とinitializeメソッド
# クラスからオブジェクトを作成する場合は以下のようにnewメソッドを使う
User.new
# この時に呼ばれるのがinitializeメソッド。インスタンスを初期化するために実行したい処理があれば、このinitializeメソッドでその処理を実装する(とくに必要がなければ定義しなくても大丈夫)
class User
  def initialize
    puts 'Initialized.'
  end
end
User.new
# => Initialized.
# initializeメソッドは特殊なメソッドで、外部から呼び出すことはできない(デフォルトでprivateメソッドになっている)
user = User.new
user.initialize
# => NoMethodError: private method 'initialize' called for #<User:0x007fb18a321ca0>

# initializeメソッドに引数をつけると、newメソッドを呼ぶ時にも引数が必要になる
class User
  def initialize(name, age)
    puts "name: #{name}, age: #{age}"
  end
end
User.new # => ArgumentError: wrong number of arguments (given 0, expected 2)
User.new('Alice', 20) # => name: Alice, 20

# インスタンスメソッドの定義
# クラス構文の内部でメソッドを定義すると、そのメソッドはインスタンスメソッドになる。インスタンスメソッドはその名の通り、そのクラスのインスタンスに対して呼び出すことができるメソッド
class User
  # インスタンスメソッドの定義
  def hello
    "Hello!"
  end
end

user = User.new
# インスタンスメソッドの呼び出し
user.hello # => "Hello!"
