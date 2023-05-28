# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/DeriGuru/Convertor"

# tests for derivative calculating stage
class TestConvertor < Minitest::Test
  include DeriGuru

  def setup
    @poly_differ = PolyDiffer.new
  end

  def test_poly_convertor_has_needed_method
    assert_respond_to @poly_differ, :Convert, is_private: true
  end

  def test_int_deri_convertor
    assert_equal "", @poly_differ.send(:Convert, [], "x")
    assert_equal "", @poly_differ.send(:Convert, [[1, 0]], "x")
    assert_equal "1", @poly_differ.send(:Convert, [[0, 1]], "x")
    assert_equal "x", @poly_differ.send(:Convert, [[1, 1]], "x")
    assert_equal "2x", @poly_differ.send(:Convert, [[1, 2]], "x")
    assert_equal "2x^3", @poly_differ.send(:Convert, [[3, 2]], "x")
    assert_equal "2x^3+x", @poly_differ.send(:Convert, [[1, 1], [3, 2]], "x")
    assert_equal "-2x^3", @poly_differ.send(:Convert, [[3, -2]], "x")
    assert_equal "-2x^3", @poly_differ.send(:Convert, [[3, -2]], "x")
    assert_equal "-2x^3+15x^2-x", @poly_differ.send(:Convert, [[1, -1], [2, 15], [3, -2]], "x")
  end

  def test_double_deri_convertor
    assert_equal "", @poly_differ.send(:Convert, [[1.5, 0]], "x")
    assert_equal "x^1.5", @poly_differ.send(:Convert, [[1.5, 1]], "x")
    assert_equal "1.5x", @poly_differ.send(:Convert, [[1, 1.5]], "x")
    assert_equal "-2x^1.5", @poly_differ.send(:Convert, [[1.5, -2]], "x")
    assert_equal "2.2x^3.5", @poly_differ.send(:Convert, [[3.5, 2.2]], "x")
    assert_equal "2.5x^3+x^1.2", @poly_differ.send(:Convert, [[1.2, 1], [3, 2.5]], "x")
    assert_equal "-2.1x^3.2", @poly_differ.send(:Convert, [[3.2, -2.1]], "x")
    assert_equal "-0.5x^3", @poly_differ.send(:Convert, [[3, -0.5]], "x")
    assert_equal "-2x^3+15.5x^2-1.8x", @poly_differ.send(:Convert, [[1, -1.8], [2, 15.5], [3, -2]], "x")
  end

  def test_multiple_variables_deri_convertor
    assert_equal "6yx^3", @poly_differ.send(:Convert, [[3, 6, "y"]], "x")
    assert_equal "yz", @poly_differ.send(:Convert, [[0, 1, "yz"]], "x")
    assert_equal "-2.2yzx^2-zx^1.6+8x-7y",
                 @poly_differ.send(:Convert, [[2, -2.2, "yz"], [1.6, -1, "z"], [1, 8, ""], [0, -7, "y"]], "x")
  end
end
