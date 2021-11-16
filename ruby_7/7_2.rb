# ユーザを表すデータをプログラム上で処理したいとする。ユーザはデータとして氏名(first_nameとlast_name)と、年齢を持つ。ハッシュと配列を使った場合
# ユーザのデータを作成する
users = []
users << { first_name: 'Alice', last_name: 'Ruby', age: 20 }
users << { first_name: 'Bob', last_name: 'Python', age: 30 }

# ユーザのデータを表示する
users.each do |user|
  puts "氏名: #{user[:first_name]} #{user[:last_name]}, 年齢: #{user[:age]}"
end
# => 氏名: Alice Ruby, 年齢: 20
# => 氏名: Bob Python, 年齢: 30


# 指名についてメソッドを作っておくと、他にも氏名を使う場面が出てきた時に再利用できる
# ユーザのデータを作成する
users = []
users << { first_name: 'Alice', last_name: 'Ruby', age: 20 }
users << { first_name: 'Bob', last_name: 'Python', age: 30 }

# 氏名を作成するメソッド
def full_name(user)
  "#{user[:first_name]} #{user[:last_name]}"
end

# ユーザのデータを表示する
users.each do |user|
  puts "氏名: #{user[:first_name]} #{user[:last_name]}, 年齢: #{user[:age]}"
end
# => 氏名: Alice Ruby, 年齢: 20
# => 氏名: Bob Python, 年齢: 30

# ハッシュを使うとキーをタイプミスした場合にnilが返ってくる。間違ったキーを指定してもエラーにはならないので、このエラーは気づきにくい
users[0][:first_name] # => 'Alice'

# ハッシュだとタイプミスしてもnilが返るだけなので不具合に気づきにくい
users[0][:first_mame] # => nil

# ほかにも、ハッシュは新しくキーを追加したり、内容を変更したりできるので「もろくて壊れやすいプログラム」になりがち。
# 勝手に新しいキーを追加
users[0][:country] = 'japan'
# 勝手にfirst_nameを変更
users[0][:first_name] = 'Carol'
# ハッシュの中身が変更される
users[0] # => {:first_name=>"Carol", :last_name=>"Ruby", :age=>20, :country=>"japan"}

# 小さなプログラムではハッシュのままでも問題ないが、大きなプログラムになってくると、とてもハッシュでは管理しきれなくなってくる。そこでクラスの登場。
# こういう場合はUserクラスという新しいデータ方を作り、そこにデータを入れた方がより堅牢なプログラムになる。
# Userクラスを定義する
class User
  attr_render :first_name, :last_name, :age

  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end
end

# ユーザのデータを作成する
users = []
users << User.new('Alice', 'Ruby', 20)
users << User.new('Bob', 'Python', 30)

# 氏名を作成するメソッド
def full_name(user)
  "#{user.first_name} #{user.last_name}"
end

# ユーザのデータを表示する
users.each do |user|
  puts "氏名: #{full_name(user)}、 年齢: #{user.age}"
end
# => 氏名: Alice Riby、 年齢: 20
#    氏名: Bob Python、 年齢: 30

# Userクラスを導入すると、タイプミスをした時にエラーが発生する
users[0].first_name # => 'Alice'

users[0].first_mame
# => NoMethodError: undefined method 'first_mame' for #<User:0x007ff2b98678c0>

# 新しく属性(データ項目)を追加したり、内容を変更したりすることも防止できる
# 勝手に属性を追加できない
users[0].country = 'japan'
# => NoMethodError: undefind method 'country=' for #<User:0x007ff2b98678c0>

# 勝手にfirst_nameを変更できない
users[0].first_name = 'Carol'
# => NoMethodError: undefind method 'first_name=' for #<User:0x007ff2b98678c0>

# また、クラスの内部にメソッドを追加することもできる。例えば、先ほど作成したfull_nameメソッドはUserクラスの内部で定義した方がシンプルになる
# Userクラスを定義する
class User
  attr_render :first_name, :last_name, :age

  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end

  # 氏名を作成するメソッド
  def full_name
    "#{first_name} #{last_name}"
  end
end

# ユーザのデータを表示する
users.each do |user|
  puts "氏名: #{full_name(user)}、 年齢: #{user.age}"
end
# => 氏名: Alice Riby、 年齢: 20
#    氏名: Bob Python、 年齢: 30

# クラスはこのように、内部にデータを保持し、さらに自分が保持しているデータを利用する独自のメソッドを持つことができる。
# データとそのデータに関するメソッドが常にセットになるので、クラスを使わない場合に比べてデータとメソッドの整理がしやすくなる。
# 小さなプログラムではそこまでメリットが見えないかもしれないが、プログラムが大規模になればなるほど、データとメソッドを一緒に持ち運べるクラスのメリットが大きくなる
