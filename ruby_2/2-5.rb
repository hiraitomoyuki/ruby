# Rubyの真偽値

# 真として扱われるもの
# trueそのもの
true

# すべての数値
1
0
-1

# すべての文字列
'true'
'false'
''

data = find_data
if data != nil
  'データがあります'
else
  'データはありません'
end

# Rubyの場合だとnilも偽なので
data = find_data
if data
  'データがあります'
else
  'データはありません'
end

# 条件1も条件2も真であれば真、それ以外は偽
条件1 && 条件2

t1 = true
t2 = true
f1 = false
t1 && t2 # => true
t1 && f1 # => false

# 条件1か条件2のいずれかが真であれば真、両方偽であれば偽
条件1 || 条件2

t1 = true
f1 = false
f2 = false
t1 || f1 # => true
f1 || f2 # => false

# && ||を組み合わせて使うことも可(&&の優先順位は||より高い)
(条件1 && 条件2) || (条件3 && 条件4)

t1 = true
t2 = true
f1 = false
f2 = false
t1 && t2 || f1 && f2     # => true
# 上の式と下の式は同じ意味
(t1 && t2) || (f1 && f2) # => true

# 優先順位を変えたい場合は()を使う
# 条件1が真かつ、条件2または条件3が真かつ、条件4が真なら真
条件1 && (条件2 || 条件3) && 条件4

t1 = true
t2 = true
f1 = false
f2 = false
t1 && (t2 || f1) && f2 # => false

# !演算子を使うと真偽値を反転することができる。つまり、真が偽に、偽が真になる
t1 = true
f1 = false
!t1 # => false
!f1 # => true

# ()と組み合わせると、()の中の真偽値を反転させることができる
t1 = true
f1 = false
t1 && f1    # => false
!(t1 && f1) # => true

# if文
if 条件A
  # 条件Aが真だった場合の処理
elsif 条件B
  # 条件Bが真だった場合の処理
elsif 条件C
  # 条件Cが真だった場合の処理
else
  # それ以外の条件の処理
end

# 条件を複数指定する場合はelse ifやelseifではなく、elsifである点に注意

# elsifやelseは不要なら省略可
if 条件A
  # 条件Aが真だった場合の処理
end

n = 11
if n > 10
  puts '10より大きい'
else
  puts '10以下'
end
# => 10より大きい

country = 'italy'
if country == 'japan'
  puts 'こんにちは'
elsif country == 'us'
  puts 'Hello'
elsif country == 'italy'
  puts 'ciao'
else
  puts '???'
end
# => ciao


country = 'italy'

# if文の戻り値を変数に代入する
greeting =
if country == 'japan'
  'こんにちは'
elsif country == 'us'
  'Hello'
elsif country == 'italy'
  'ciao'
else
  '???'
end

greeting # => "ciao"


point = 7
day = 1
# 1日であればポイント5倍
if day == 1
  point *= 5
end
point # => 35

# 上記のコードをif文を修飾子として使うことができる
point = 7
day = 1
# 1日であればポイント5倍(if修飾子を利用)
point *= 5 if day == 1
point # => 35


# ifとelsifの後ろにはthenを入れることも可 (thenを入れると、条件式とその条件が真だった場合の処理を1行に押し込めることも可)
if 条件A then
  # 条件Aが真だった場合の処理
elsif 条件B then
  # 条件Bが真だった場合の処理
else
  # それ以外の条件の処理
end

country = 'italy'
if country == 'japan' then 'こんにちは'
elsif country == 'us' then 'Hello'
elsif country == 'italy' then 'ciao'
else '???'
end
# => "ciao"