# 真偽値と条件分岐

# && ||の戻り値と評価を終了するタイミング
1 && 2 && 3     # => 3        1,2の段階ではまだ真偽がつかないため
1 && nil && 3   # => nil      nilの段階で偽が確定したため
1 && false && 3 # => false    falseの段階で偽が確定したため

nil || false # => false        nilの段階ではまだ真偽がつかないため
false || nil # => nil          falseの段階ではまだ真偽がつかないため
nil || false || 2 || 3 # => 2  nil,falseは偽で2の時点で真が確定したため

# if文のように、真または偽のどちらか　であればかまわないケースでは、戻り値が具体的に何か意識する必要はない
# ただし、Rubyではif文以外のところで&&や||を意図的に使う場合がある。

# Alice, Bob, Carolと順に検索し、最初に見つかったユーザ(nilまたはfalse以外の値)を変数に格納する
user = find_user('Alice') || find_user('Bob') || find_user('Carol')

# 正常なユーザであればメールを送信する(左辺が偽であればメール送信は実行されない)
user.valid? && send_email_to(user)


# 優先順位

t1 = true
f1 = false
t1 and f1 # => false
t1 or f1  # => true
not t1    # => false

# 英語の理論演算子と記号の理論演算子を混在させたりすると結果が異なる場合がある
t1 = true
f1 = false
!f1 || t1    # => true
not f1 || t1 # => false

# !は||よりも優先順位が高い
!(f1) || t1
# notは||よりも優先順位が低い
not(f1 || t1)


# &&,||と異なり、andとorは優先順位に違いがない。()を使わない場合は左から右に順番に真偽値が評価される
t1 = true
t2 = true
f1 = false

t1 || t2 && f1   # => true
t1 or t2 and f1  # => false

# &&は||よりも優先順位が高い
t1 || (t2 && f1)
# andとorの優先順位は同じなので、左から順に評価される
(t1 or t2) and f1



user.valid? && send_email_to user
# => SyntaxError: syntax error, unexpected tIDENTIFIER, expecting keyword_do or '{' or '('
#    er.valid? && send_to user
#                             ^
(user.valid? && send_email_to) user

user.valid? and send_email_to user
(user.valid?) and (send_email_to user)

# ただし、下記のように記載すれば構文エラーにはならない
user.valid? && send_email_to(user)


# orも「Aが真か？　真でなければBせよ」という制御フローを実現する際に便利
def greeting(country)
  # countryがnil(またはfalse)ならメッセージを返してメソッドを抜ける
  country or return 'countryを入力してください'

  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end
greeting(nil)     # => "countryを入力してください"
greeting('japan') # => "こんにちは"


# unless文
# ifと反対の意味を持つ。条件式が偽になった場合のみ処理を実行する
# if文で否定の条件を書いているときは、unless文に書き換えられる

status = 'error'
if status != 'ok'
  '何か異常があります'
end
# => "何か異常があります"

status = 'ok'
unless status == 'ok'
  '何か異常があります'
else
  '正常です'
end
# => "正常です"


# だたし、if文のelsifに相当するもの(elsunlessのような条件分岐)は存在しない
# unlessはifと同様、unlessの戻り値を直接変数に代入したり、修飾子として文の後ろに置いたりできる
status = 'error'

# unlessの結果を変数に代入する
message =
  unless status == 'ok'
    '何か異常があります'
  else
    '正常です'
  end

message # => '何か異常があります'

# unlessを修飾子として使う
'何か異常があります' unless status == 'ok'
# => "何か異常があります"

# if文と同様、thenを入れることができる
status = 'error'
unless status = 'ok' then
  '何か異常があります'
end
# => "何か異常があります"

status = 'error'
# unlessを無理に使わなくても良い
if status != 'ok'
  '何か異常があります'
end
# => "何か異常があります"


# case文
# 複数の条件を指定する場合は、elsifを重ねるよりもcase文で書いた方がシンプルになる

country = 'italy'

# if文を使う場合
if country == 'japan'
  'こんにちは'
elsif country == 'us'
  'Hello'
elsif country == 'italy'
  'ciao'
else
  '???'
end
# => "ciao"

# case文を使う場合
case country
when 'japan'
  'こんにちは'
when 'us'
  'Hello'
when 'italy'
  'ciao'
else
  '???'
end
# => "ciao"

# Rubyのcase文ではwhen節に複数の値を指定し、どれかに一致すれば処理を実行するという条件分岐が可

# when節に複数の値を指定する
country = 'アメリカ'
case country
when 'japan', '日本'
  'こんにちは'
when 'us', 'アメリカ'
  'Hello'
when 'italy', 'イタリア'
  'ciao'
else
  '???'
end
# => "Hello"

# if文と同様、case文も最後に評価された式を戻り値として返すため、case文の結果を変数に入れることが可能
country = 'italy'

message =
  case country
  when 'japan'
    'こんにちは'
  when 'us'
    'Hello'
  when 'italy'
    'ciao'
  else
    '???'
  end

message # => "ciao"

# when節の後ろにはthenを入れることができる。thenを入れるとwhen節とその条件が真だった場合の処理を1行で書くことができる
country = 'italy'

case country
when 'japan' then 'こんにちは'
when 'us' then 'Hello'
when 'italy' then 'ciao'
else '???'
end
# => "ciao"


# 条件演算子

n = 11
if n > 10
  '10より大きい'
else
  '10以下'
end
# => "10より大きい"

n = 11
n > 10 ? '10より大きい' : '10以下'
# => "10より大きい"

n = 11
message = n > 10 ? '10より大きい' : '10以下'
message # => "10より大きい"