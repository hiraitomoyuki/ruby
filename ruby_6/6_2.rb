# 正規表現とは
# パターンを指定して、文字列を効率よく検索/置換するためのミニ言語
# RegexpやRegexという言葉を見かけたら正規表現のことを示している

I love Ruby.
Python is a great language.
Java and JavaScript are different.
# この中から、「プログラミング言語っぽい文字列を抜き出すプログラムを書く」
text = << TEXT
I love Ruby.
Python is a great language.
Java and JavaScript are different.
TEXT

text.scan(/[A-Z][A-Za-z]+/) # => ["Ruby", "Python", "Java", "JavaScript"]
# scanメソッドに渡した/[A-Z][A-Za-z]+/が正規表現。

私の郵便番号は1234567です。
僕の住所は6770056 兵庫県西脇市板波町1234だよ。
# Rubyを使ってハイフンで区切る
text = << TEXT
私の郵便番号は1234567です。
僕の住所は6770056 兵庫県西脇市板波町1234だよ。
TEXT

puts text.gsub(/(\d{3}))(\d{4})/,'\1-\2')
# => 私の郵便番号は123-4567です。
#    僕の住所は677-0056 兵庫県西脇市板波町1234だよ。
