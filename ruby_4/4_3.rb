# Rubyの繰り返し処理
# doからendまでがブロックの範囲
numbers = [1, 2, 3, 4]
sum = 0
numbers.each do |n|
  sum += n
end
sum # => 10
# |n|はnのブロック引数と呼ばれるもので、eachメソッドから渡された配列の要素が入る

