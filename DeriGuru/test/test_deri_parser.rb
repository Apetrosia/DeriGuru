# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/DeriGuru/deri_parser"

# tests for parsing
class TestDeriParser < Minitest::Test
  include DeriGuru

  def setup
    @poly_differ = PolyDiffer.new
  end

  def test_poly_differ_has_needed_method
    assert_respond_to @poly_differ, :poly_parse, is_private: true
  end

  def test_empty_poly
    assert_empty(@poly_differ.send(:poly_parse, "", ""))
  end

  def test_one_int_var
    assert_equal([[1, 1, ""]], @poly_differ.send(:poly_parse, "x", "x"))
    assert_equal([[0, 1, ""]], @poly_differ.send(:poly_parse, "1", "x"))
    assert_equal([[1, 2, ""]], @poly_differ.send(:poly_parse, "2x", "x"))
    assert_equal([[3, 1, ""]], @poly_differ.send(:poly_parse, "x^3", "x"))
    assert_equal([[4, 5, ""]], @poly_differ.send(:poly_parse, "5x^4", "x"))
    assert_equal([[1, -1, ""]], @poly_differ.send(:poly_parse, "-x", "x"))
    assert_equal([[0, -1, ""]], @poly_differ.send(:poly_parse, "-1", "x"))
    assert_equal([[1, -2, ""]], @poly_differ.send(:poly_parse, "-2x", "x"))
    assert_equal([[3, -1, ""]], @poly_differ.send(:poly_parse, "-x^3", "x"))
    assert_equal([[4, -5, ""]], @poly_differ.send(:poly_parse, "-5x^4", "x"))
  end

  def test_one_float_var
    assert_equal([[1, 5.8, ""]], @poly_differ.send(:poly_parse, "5.8x", "x"))
    assert_equal([[2, -5.8, ""]], @poly_differ.send(:poly_parse, "-5.8x^2", "x"))
    assert_equal([[0, 2.4, ""]], @poly_differ.send(:poly_parse, "2.4", "x"))
    assert_equal([[0, -2.4, ""]], @poly_differ.send(:poly_parse, "-2.4", "x"))
  end

  def test_same_power_vars
    assert_equal([[3, 5, ""]], @poly_differ.send(:poly_parse, "2x^3+3x^3", "x"))
    assert_equal([[1, 5, ""]], @poly_differ.send(:poly_parse, "x+4x", "x"))
    assert_equal([[2, 2.3, ""]], @poly_differ.send(:poly_parse, "3.4x^2-1.1x^2", "x"))
    assert_equal([[1, 2.4, ""]], @poly_differ.send(:poly_parse, "6x-3.6x", "x"))
    assert_equal([[2, 9.5, ""]], @poly_differ.send(:poly_parse, "5x^2+4.5x^2", "x"))
    assert_equal([[0, -8, ""]], @poly_differ.send(:poly_parse, "10-18", "x"))
  end

  def test_random_power_vars
    assert_equal([[1, 5, ""], [2, 7, ""]], @poly_differ.send(:poly_parse, "x+4x+7x^2", "x"))
    assert_equal([[1, 4.5, ""], [2, 8, ""]], @poly_differ.send(:poly_parse, "x^2+4.5x+7x^2", "x"))
    assert_equal([[0, -1, ""], [1, 2, ""]], @poly_differ.send(:poly_parse, "5-6+2x", "x"))
    assert_equal([[0, -5, ""], [1, 7, ""]], @poly_differ.send(:poly_parse, "2x+4+5x-9", "x"))
  end

  def test_term_without_diff_var
    assert_equal([[0, 2, "y"]], @poly_differ.send(:poly_parse, "2y", "x"))
    assert_equal([[0, 2, "y"], [0, 3, "z"]], @poly_differ.send(:poly_parse, "2y+3z", "x"))
    assert_equal([[0, 5, "y"]], @poly_differ.send(:poly_parse, "2y+3y", "x"))
  end

  def test_several_vars_in_one_term
    assert_equal([[1, 2, "y"]], @poly_differ.send(:poly_parse, "2xy", "x"))
    assert_equal([[1, 2, "y"]], @poly_differ.send(:poly_parse, "2yx", "x"))
    assert_equal([[1, 2, "yz"]], @poly_differ.send(:poly_parse, "2xyz", "x"))
    assert_equal([[1, 2, "yz"]], @poly_differ.send(:poly_parse, "2zyx", "x"))
  end

  def test_several_vars_in_several_terms
    assert_equal([[1, 2, "y"], [1, 3, ""]], @poly_differ.send(:poly_parse, "2xy+3x", "x"))
    assert_equal([[1, 2, ""], [1, 2, "y"]], @poly_differ.send(:poly_parse, "2xy+2x", "x"))
    assert_equal([[1, 5, "y"]], @poly_differ.send(:poly_parse, "2xy+3xy", "x"))
    assert_equal([[1, 5, "y"]], @poly_differ.send(:poly_parse, "2xy+3yx", "x"))
    assert_equal([[1, -6, "yz"]], @poly_differ.send(:poly_parse, "2xyz+3zyx-11yzx", "x"))
  end

  def test_several_power_var_in_one_term
    assert_equal([[1, 2, "y^2"]], @poly_differ.send(:poly_parse, "2xy^2", "x"))
    assert_equal([[1, 2, "y^2"]], @poly_differ.send(:poly_parse, "2y^2x", "x"))
    assert_equal([[1, 2, "y^2z"]], @poly_differ.send(:poly_parse, "2xy^2z", "x"))
    assert_equal([[1, 2, "y^2z"]], @poly_differ.send(:poly_parse, "2zy^2x", "x"))
  end

  def test_several_power_vars_in_several_terms
    assert_equal([[1, 2, "y^2"], [1, 3, ""]], @poly_differ.send(:poly_parse, "2xy^2+3x", "x"))
    assert_equal([[1, 2, ""], [1, 2, "y^2"]], @poly_differ.send(:poly_parse, "2xy^2+2x", "x"))
    assert_equal([[1, 5, "y^2"]], @poly_differ.send(:poly_parse, "2xy^2+3xy^2", "x"))
    assert_equal([[1, 5, "y^2"]], @poly_differ.send(:poly_parse, "2xy^2+3y^2x", "x"))
    assert_equal([[1, -6, "y^2z^3"]], @poly_differ.send(:poly_parse, "2xy^2z^3+3z^3y^2x-11y^2z^3x", "x"))
  end
end
