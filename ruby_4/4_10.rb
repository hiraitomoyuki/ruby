# 繰り返し処理用の制御構造
# Rubyには繰り返し処理を動きを変えるための制御構造が用意されている。
・break
・next
・redo
# また、Kernelモジュールのthrowメソッドとcatchメソッドもbreakと同じような用途で使われる

# break
# shuffleメソッドで配列の要素をランダムに並び替える
numbers = [1, 2, 3, 4, 5].shuffle
numbers.each do |n|
  puts n
  # 5が出たら繰り返しを脱出する
  break if n == 5
end

# breakはeachメソッドだけでなく、while文やuntil文、for文でも使える
numbers = [1, 2, 3, 4, 5].shuffle
i = 0
while i < numbers.size
  n = numbers[i]
  puts n
  break if n == 5
  i += 1
end
# breakに引数を渡すと、while文やfor文の戻り値になる。引数を渡さない場合の戻り値はnil
ret =
  while true
    break
  end
ret # => nil

ret =
  while true
    break 123
  end
ret # => 123

# 繰り返し処理が入れ子になっている場合は、一番内側の繰り返し処理を脱出する
fruits = ['apple', 'melon', 'orange']
numbers = [1, 2, 3]
fruits.each do |fruit|
  # 配列の数字をランダムに入れ替え、3が出たらbreakする
  numbers.shuffle.each do |n|
    puts "#{fruit}, #{n}"
    # numbersのループは脱出するが、fruitsのループは継続する
    break if n == 3
  end
end

# throwとcatchを使った大域脱出
# 一気に外側のループまで脱出したい場合は、Kernelモジュールのthrowメソッドとcatchメソッドを使う
catch タグ do
  # 繰り返し処理など
  throw タグ
end
# throw,catchというキーワードは、他の言語では例外処理に使われる場合があるが、Rubyのthrow,catchは例外処理とは関係ない
# throwメソッドとcatchを使って"orange"と3の組み合わせが出たらすべての繰り返し処理を脱出するコード
fruits = ['apple', 'melon', 'orange']
numbers = [1, 2, 3]
catch :done do
  fruits.shuffle.each do |fruit|
    numbers.shuffle.each do |n|
      puts "#{fruit}, #{n}"
      if fruit == 'orange' && n == 3
        # すべての繰り返し処理を脱出する
        throw :done
      end
    end
  end
end
# => melon, 2
#    melon, 1
#    melon, 3
#    orange, 1
#    orange, 3

# throwとcatchのタグが一致しない場合はエラーが発生する
fruits = ['apple', 'melon', 'orange']
numbers = [1, 2, 3]
catch :done do
  fruits.shuffle.each do |fruit|
    numbers.shuffle.each do |n|
      puts "#{fruit}, #{n}"
      if fruit == 'orange' && n == 3
        # catchと一致しないタグをthrowする
        throw :foo
      end
    end
  end
end
# => orange, 1
#    orange, 3
#    UncaughtThrowError: uncaught throw :foo

# throwメソッドに第2引数を渡すとcatchメソッドの戻り値になる
ret =
  catch :done do
    throw :done
  end
ret # => nil

ret =
  catch :done do
    throw :done, 123
  end
ret # => 123
