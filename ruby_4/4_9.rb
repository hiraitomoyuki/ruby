# さまざまな繰り返し処理

# timesメソッド
# 配列を使わずに、単純にn回処理を繰り返したい、という場合はIntegerクラスのtimesメソッドを使うと便利
sum = 0
# 処理を5回繰り返す。nには0, 1, 2, 3, 4が入る
5.times { |n| sum += n }
sum # => 10
# 不要であればブロック引数は省略してもok
sum = 0
# sumに1を加算する処理を5回繰り返す
5.times { sum += 1 }
sum # => 5