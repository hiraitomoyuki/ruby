# シンボル
# シンボルは次のようにコロン(:)に続けて任意の名前を定義する(シンボルリテラル)
:シンボルの名前

# シンボルを作成するコード例
:apple
:japan
:ruby_is_fun

# シンボルとよく似た文字列を作るコード例
'apple'
'japan'
'ruby_is_fun'


# シンボルと文字列の違い
# シンボルはSymbolクラスのオブジェクト。文字列はStringクラスのオブジェクト。
:apple.class  # => Symbol
'apple'.class # => String

# シンボルはRubyの内部で整数として管理される。表面的には文字列と同じように見えるが、その中身は整数。そのため、2つの値が同じかどうか調べる場合、文字列よりも高速に処理できる
# 文字列よりもシンボルの方が高速に比較できる
'apple' == 'apple'
:apple == :apple

# シンボルは「同じシンボルであればまったく同じオブジェクトである」という特徴がある
# このため、「大量の同じ文字列」と「大量の同じシンボル」を作成した場合、シンボルの方がメモリの使用効率がよくなる
# まったく同じオブジェクトであるかどうかはobject_idを調べるとわかる
:apple.object_id # => 1143388
:apple.object_id # => 1143388
:apple.object_id # => 1143388

'apple'.object_id # => 70223819213380
'apple'.object_id # => 70223819233120
'apple'.object_id # => 70223819227780
# シンボルはすべて同じIDだが、文字列は3つとも異なるIDになる
# シンボルはイミュータブルなオブジェクト。文字列のように破壊的な変更はできないため、「何かに名前をつけたい。名前なので誰かによって勝手に変更されては困る」と言う用途に向いている

# 文字列は破壊的な変更が可能
string = 'apple'
string.upcase!
string # => "APPLE"

# シンボルはイミュータブルなので、破壊的な変更は不可能
symbol = :apple
symbol.upcase! # => NoMethodError: undefined method 'upcase!' for :apple:Symbol
