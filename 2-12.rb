# エイリアスメソッド
# Rubyには同じメソッドに複数の名前がついている場合がある。これをエイリアスメソッドと呼ぶ

# lengthもsizeも、どちらも文字数を返す
'hello'.length # => 5
'hello'.size   # => 5

# 式と文の違い
# 式…値を返し、結果を変数に代入できるもの
# 文…値を返さず、変数に代入しようとすると構文エラーになるもの

# if文が値を返すので変数に代入できる
a =
  if true
    '真です'
  else
    '偽です'
  end
a # => "真です"

# メソッドの定義も実は値(シンボル)を返している
b = def foo; end
b # => :foo


