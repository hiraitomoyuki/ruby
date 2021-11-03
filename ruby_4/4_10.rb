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

# 繰り返し処理で使うbreakとreturnの違い
# これは積極的に使うべきテクニックではなく、挙動が複雑になるので極力使わないようにした方がよい内容
def greeting(country)
  # countryがnilならメッセージを返してメソッドを抜ける
  return 'countryを入力してください' if country.nil?

  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end

# 繰り返し処理の中でもreturnは使えるが、breakとreturnは同じではない。breakを使うと「繰り返し処理からの脱出」になるが、returnを使うと「(繰り返し処理のみならず)メソッドからの脱出」になる
# 「配列の中からランダムに1つの偶数を選び、その数を10倍して返すメソッド」のコード
def calc_with_break
  numbers = [1, 2, 3, 4, 5, 6]
  target = nil
  numbers.shuffle.each do |n|
    target = n
    # berakで脱出する
    break if n.even?
  end
  target * 10
end
calc_with_break # => 40

# breakの代わりにreturnを使うと次のようになる
def calc_with_return
  numbers = [1, 2, 3, 4, 5, 6]
  target = nil
  numbers.shuffle.each do |n|
    target = n
    # returnで脱出する？
    return if n.even?
  end
  target * 10
end
calc_with_return # => nil
# calc_with_returnの戻り値がなぜnilになったかと言うと、returnが呼ばれた瞬間にメソッド全体を脱出してしまったから。returnには引数を渡していないので、結果としてメソッドの戻り値はnilになる。
# また、returnの役割はあくまで「メソッドからの脱出」なので、returnを呼び出した場所がメソッドの内部でなければエラーになる。
[1, 2, 3].each do |n|
  puts n
  return
end
# => 1
#    LocalJumpError: unexpected return
# このように、breakとreturnは「脱出する」という目的は同じでも、「繰り返し処理からの脱出」と「メソッドからの脱出」という大きな違いがあるため、用途に応じて適切に使い分ける必要がある。

# next
# 繰り返し処理を途中で中断し、次の繰り返し処理を進める場合はnextを使う。
# 偶数であれば処理を中断して次の繰り返し処理に進むコード
numbers = [1, 2, 3, 4, 5]
numbers.each do |n|
  # 偶数であれば中断して次の繰り返し処理に進む
  next if n.even?
  puts n
end
# => 1
#    3
#    5

# eachメソッドの中だけでなく、while文やuntil文、for文の中でも使える点や、入れ子になった繰り返し処理では一番内側のループだけが中断の対象になる点はbreakと同じ
numbers = [1, 2, 3, 4, 5]
i = 0
while i < numbers.size
  n = numbers[i]
  i += 1
  # while文の中でnextを使う
  next if n.even?
  puts n
end
# => 1
#    3
#    5

fruits = ['apple', 'melon', 'orange']
numbers = [1, 2, 3, 4]
fruits.each do |fruit|
  numbers.each do |n|
    # 繰り返し処理が入れ子になっている場合は、一番内側のループだけが中断される
    next if n.even?
    puts "#{fruit}, #{n}"
  end
end
# => apple, 1
#    allpe, 3
#    melon, 1
#    melon, 3
#    orange, 1
#    orange, 3

# redo
# 繰り返し処理をやりなおしたい場合はredoを使う。ここでいう「やりなおし」は初回からやりなおすのではなく、その回の繰り返し処理の最初に戻る、と言う意味
# 3つの野菜に対して「好きですか？」と問いかけ、ランダムに「はい」または「いいえ」を答えるプログラム。ただし、「はい」と答えるまで何度も同じ質問が続く
foods = ['ピーマン', 'トマト', 'セロリ']
foods.each do |food|
  print "#{food}は好きですか？ => "
  # sampleは配列からランダムに1要素を取得するメソッド
  answer = ['はい', 'いいえ'].sample
  puts answer

  # はいと答えなければもう一度聞き直す
  redo unless answer == 'はい'
end
# => ピーマンは好きですか？ => いいえ
#    ピーマンは好きですか？ => いいえ
#    ピーマンは好きですか？ => はい
#    トマトは好きですか？ => はい
#    セロリは好きですか？ => いいえ
#    セロリは好きですか？ => はい

# redoを使う場合は、状況によっては永遠にやり直しが続くかもしれない。そうすると、意図せず無限ループを作ってしまう。なのでやり直しの回数を制限することを検討する
foods = ['ピーマン', 'トマト', 'セロリ']
count = 0
foods.each do |food|
  print "#{food}は好きですか？ => "
  # わざと「いいえ」しか答えられないようにする
  answer = 'いいえ'
  puts answer

  count += 1
  # やりなおしは2回までにする
  redo if answer != 'はい' && count < 2

  # カウントをリセット
  count = 0
end