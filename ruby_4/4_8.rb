# Rubyではeachメソッドを使って繰り返し処理を行う場合が大半。しかし、eachメソッドでは何番目の要素を処理しているか、ブロック内で判別できない。
# 繰り返し処理をしつつ、処理している要素の添え字も取得したい時は、each_with_indexメソッドを使うと便利。ブロック引数の第2引数に添え字を渡してくれる
fruits = ['apple', 'orange', 'melon']
# ブロック引数のiには0, 1, 2...と要素の添え字が入る
fruites.each_with_index { |fruit, i| puts "#{i}: #{fruit}" }
# => 0: apple
#    1: orange
#    2: melon