# テストコード雛形
require 'minitest/autorun'

class SampleTest < Minitest::Test
  def test_sample
    assert_equal 'RUBY', 'ruby'.upcase
  end
end

# aとbが等しければパスする
assert_equal b, a

# aが真であればパスする
assert a

# aが偽であればパスする
refute a
