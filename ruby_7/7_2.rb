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
