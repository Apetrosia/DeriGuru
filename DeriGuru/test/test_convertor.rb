# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/DeriGuru/convertor"

# tests for derivative calculating stage
class TestConvertor < Minitest::Test
  include DeriGuru

  def test_poly_convertor_has_needed_method
    assert_respond_to PolyDiffer, :convert, is_private: true
  end

  def test_int_deri_convertor
    assert_equal "", PolyDiffer.send(:convert, [], "x")
    assert_equal "", PolyDiffer.send(:convert, [[1, 0]], "x")
    assert_equal "1", PolyDiffer.send(:convert, [[0, 1]], "x")
    assert_equal "x", PolyDiffer.send(:convert, [[1, 1]], "x")
    assert_equal "2x", PolyDiffer.send(:convert, [[1, 2]], "x")
    assert_equal "2x^3", PolyDiffer.send(:convert, [[3, 2]], "x")
    assert_equal "2x^3+x", PolyDiffer.send(:convert, [[1, 1], [3, 2]], "x")
    assert_equal "-2x^3", PolyDiffer.send(:convert, [[3, -2]], "x")
    assert_equal "-2x^3", PolyDiffer.send(:convert, [[3, -2]], "x")
    assert_equal "-2x^3+15x^2-x", PolyDiffer.send(:convert, [[1, -1], [2, 15], [3, -2]], "x")
  end

  def test_double_deri_convertor
    assert_equal "", PolyDiffer.send(:convert, [[1.5, 0]], "x")
    assert_equal "x^1.5", PolyDiffer.send(:convert, [[1.5, 1]], "x")
    assert_equal "1.5x", PolyDiffer.send(:convert, [[1, 1.5]], "x")
    assert_equal "-2x^1.5", PolyDiffer.send(:convert, [[1.5, -2]], "x")
    assert_equal "2.2x^3.5", PolyDiffer.send(:convert, [[3.5, 2.2]], "x")
    assert_equal "2.5x^3+x^1.2", PolyDiffer.send(:convert, [[1.2, 1], [3, 2.5]], "x")
    assert_equal "-2.1x^3.2", PolyDiffer.send(:convert, [[3.2, -2.1]], "x")
    assert_equal "-0.5x^3", PolyDiffer.send(:convert, [[3, -0.5]], "x")
    assert_equal "-2x^3+15.5x^2-1.8x", PolyDiffer.send(:convert, [[1, -1.8], [2, 15.5], [3, -2]], "x")
    assert_equal "", PolyDiffer.send(:convert, [[1, 0, ""]], "x")
    assert_equal "1", PolyDiffer.send(:convert, [[0, 1, ""]], "x")
    assert_equal "x", PolyDiffer.send(:convert, [[1, 1, ""]], "x")
    assert_equal "2x", PolyDiffer.send(:convert, [[1, 2, ""]], "x")
    assert_equal "2x^3", PolyDiffer.send(:convert, [[3, 2, ""]], "x")
    assert_equal "2x^3+x", PolyDiffer.send(:convert, [[1, 1, ""], [3, 2, ""]], "x")
    assert_equal "-2x^3", PolyDiffer.send(:convert, [[3, -2, ""]], "x")
    assert_equal "-2x^3", PolyDiffer.send(:convert, [[3, -2, ""]], "x")
    assert_equal "-2x^3+15x^2-x", PolyDiffer.send(:convert, [[1, -1, ""], [2, 15, ""], [3, -2, ""]], "x")
  end

  def test_multiple_variables_deri_convertor
    assert_equal "6yx^3", PolyDiffer.send(:convert, [[3, 6, "y"]], "x")
    assert_equal "6yzx^3", PolyDiffer.send(:convert, [[3, 6, "yz"]], "x")
    assert_equal "6.5yx", PolyDiffer.send(:convert, [[1, 6.5, "y"]], "x")
    assert_equal "zx^3.8", PolyDiffer.send(:convert, [[3.8, 1, "z"]], "x")
    assert_equal "yz", PolyDiffer.send(:convert, [[0, 1, "yz"]], "x")

    assert_equal "-2.2yzx^2-zx^1.6+8x-7y",
                 PolyDiffer.send(:convert, [[2, -2.2, "yz"], [1.6, -1, "z"], [1, 8, ""], [0, -7, "y"]], "x")

    assert_equal "-zx^2-2.2yzx^2+8x-7y",
                 PolyDiffer.send(:convert, [[0, -7, "y"], [1, 8, ""], [2, -1, "z"], [2, -2.2, "yz"]], "x")
    assert_equal "-zx^2-2.2yzx^2+8yx-7",
                 PolyDiffer.send(:convert, [[0, -7, ""], [1, 8, "y"], [2, -1, "z"], [2, -2.2, "yz"]], "x")
    assert_equal "8y^2x-7y", PolyDiffer.send(:convert, [[0, -7, "y"], [1, 8, "y^2"]], "x")
    assert_equal "8y^2x^3-7y", PolyDiffer.send(:convert, [[0, -7, "y"], [3, 8, "y^2"]], "x")
    assert_equal "8y^2zx^3-2.5yx^2", PolyDiffer.send(:convert, [[2, -2.5, "y"], [3, 8, "y^2z"]], "x")
  end
end
