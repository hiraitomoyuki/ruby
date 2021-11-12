# シンボルを作成するさまざまな方法
# シンボルを作成する場合はコロンに続けて、変数名やクラス名、メソッド名の識別子として有効な文字列を書く。
# 識別子として無効な文字列(数字から始まったり、ハイフンやスペースが含まれていたりする文字列)を使うとエラーが発生する
# ただし、その場合でもシングルクオートで囲むとシンボルとして有効になる
# シングルクオートの代わりにダブルクオートを使うと、文字列と同じように式展開を使うことができる
name = 'Allice'
:"#{name.upcase}" # => :ALLICE
# ハッシュを作成する際に、"文字列: 値"の形式で書いた場合も":文字列"と同じようにみなされ、キーがシンボルになる
# "文字列: 値"の形式で書くと、キーがシンボルになる
hash = { 'abc': 123 } # => {:abc=>123}

# %記法でシンボルやシンボルの配列を作成する
# %記法を使ってシンボルを作成することもできる。シンボルを作成する場合は%sを使う
# !を区切り文字に使う
%s!ruby is fun! # => :"ruby is fun"

# ()を区切り文字に使う
%s(ruby is fun) # => :"ruby is fun"

# シンボルの配列を作成する場合は、%iを使うことができる。この場合、空白文字が要素の区切りになる
%i(apple orange melon) # => [:apple, :orange, :melon]

# 改行文字を含めたり、式展開したりする場合は%Iを使う
name = 'Alice'

# %iでは改行文字や式展開の構文が、そのままシンボルになる
%i(hello\ngood-bye #{name.upcase}) # => [:"hello\\ngood-bye", :"\#{name.upcase}"]

# %Iでは改行文字や式展開が有効になったうえでシンボルが作られる
%I(hello\ngood-bye #{name.upcase}) # => [:"hello\ngood-bye, :ALICE"]

# シンボルと文字列の関係
# 文字列とシンボルは見た目は似ていても、別物なので互換性はない
# ただし、to_symメソッド(エイリアスメソッドはintern)を使うと、文字列をシンボルに変換することができる
string = 'apple'
symbol = :apple

string == symbol        # => false
string.to_sym == symbol # => true

# 反対に、シンボルを文字列に変換する場合はto_sメソッド(エイリアスメソッドはid2name)を使う
string = 'apple'
symbol = :apple

symbol.to_s           # => "apple"
string == symbol.to_s # => true
string + symbol.to_s  # => "appleapple"

# メソッドによっては文字列とシンボルを同等に扱うものがある。たとえば、respond_to?メソッドはオブジェクトに対して、文字列またはシンボルで指定した名前のメソッドを呼び出せるかどうか調べることができる
# respond_to?メソッドの引数には文字列とシンボルの両方を渡せる
'apple'.respond_to?('include?') # => true
'apple'.respond_to?(:include?)  # => true

'apple'.respond_to?('foo_bar') # => false
'apple'.respond_to?(:foo_bar)  # => false

# しかし、文字列とシンボルを同等に扱うかどうかはメソッドの仕様による。一般的には同等に扱わない(文字列とシンボルを区別する)ケースの方が多い
# 文字列に'pp'が含まれるか調べる
'apple'.include?('pp') # => true

# シンボルを引数で渡すとエラーになる
'apple'.include?(:pp)  # => TypeError: no implicit conversions of Symbol into String