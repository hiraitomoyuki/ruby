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

# クラス
# クラスは一種のデータ型。「オブジェクトの設計図」や「オブジェクトの雛形」と呼ばれることもある。
# Rubyではオブジェクトは必ず何らかのクラスに属している。クラスが同じであれば、保持している属性 (データ項目)や使えるメソッドは(原則として)同じになる

# オブジェクト、インスタンス、レシーバ
# クラスはあくまで設計図なので、設計図だけ持っていても仕方ない。オブジェクト指向プログラミングではクラスからさまざまなオブジェクトが作成できる。
# 同じクラスから作られたオブジェクトは同じ属性(データ項目)やメソッドを持つが、属性の中に保持されるデータ(名前や数値、色など)はオブジェクトによって異なる

# 「Alice Rubyさん、20歳」というユーザのオブジェクトを作成する
alice = User.new('Alice', 'Ruby', 20)
# 「Bob Pythonさん、 30歳」というユーザのオブジェクトを作成する
bob = User.new('Bob', 'Python', 30)

# どちらもfull_nameメソッドを持つが、保持しているデータが異なるので戻り値は異なる
alice.full_name
# => "Alice Ruby"
bob.full_name
# => "Bob Python"

# このように、クラスを元にして作られたデータの塊をオブジェクトと呼ぶ
# 場合によってはオブジェクトではなくインスタンスと呼ぶこともある
# 「これはUserクラスのオブジェクトです」 = 「これはUserクラスのインスタンスです」
# また、メソッドとの関係を説明する場合には、オブジェクトのことをレシーバと呼ぶこともある
user = User.new('Alice', 'Ruby', 20)
user.first_name
# 「2行目でUserオブジェクトのfirst_nameメソッドを呼び出しています」
# 「ここでのfirst_nameメソッドのレシーバはuserです」
# レシーバは英語で書くと"receiver"で「受け取る人」や「受信者」という意味。なので、「レシーバ」は「メソッドを呼び出された側」というニュアンスを出したい時に使われる

# メソッド、メッセージ
# オブジェクトが持つ「動作」や「振る舞い」をメソッドと呼ぶ。「オブジェクトの動作」とか「振る舞い」と呼ぶとすごく難しく聞こえるかもしれないが、要するに何らかの処理をひとまとめにして名前をつけ、何度も再利用できるようにしたものがメソッド。
user = User.new('Alice', 'Ruby', 20)
user.first_name
# このコードは「2行目ではuserというレシーバに対して、first_nameというメッセージを送っている」と説明されることがある
# レシーバとメッセージという呼び方は、Smaltalkというオブジェクト指向言語でよく使われる呼び方

# 状態(ステート)
# オブジェクトごとに保持されるデータのことを「オブジェクトの状態(もしくはステート)」と呼ぶことがある
# 例えば、「信号機オブジェクトの状態は赤です」といった感じ。また、Userクラスが持つ「名前」や「年齢」といったデータも、オブジェクト指向の考え方で言うと「Userの状態」に含まれる

# 属性(アトリビュート、プロパティ)
# オブジェクトの状態(オブジェクト内の各データ)は外部から取得したり変更したりできる場合がある
class User
  # first_nameの読み書きを許可する
  attr_accessor :first_name
  # 省略
end
user = User.new('Alice', 'Ruby', 20)
user.first_name # => 'Alice'
# first_nameを変更する
user.first_name = 'ありす'
user.first_name # => "ありす"
# このようにオブジェクトから取得(もしくはオブジェクトに設定)できる値のことを属性(もしくはアトリビュートやプロパティ)と呼ぶ。多くの場合、属性の名前は名詞になっている
