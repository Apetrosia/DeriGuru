# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/DeriGuru/deri_parser"

# tests for parsing
class TestDeriParser < Minitest::Test
  include DeriGuru

  def setup
    @poly_parser = PolyParser.new
  end

  def test_poly_parser_has_needed_method
    assert_respond_to @poly_parser, :poly_parse, is_private: true
  end

  def test_empty_poly
    assert_empty(@poly_parser.send(:poly_parse, ""))
  end

  def test_one_int_var
    assert_equal([[1, 1]], @poly_parser.send(:poly_parse, "x"))
    assert_equal([[0, 1]], @poly_parser.send(:poly_parse, "1"))
    assert_equal([[1, 2]], @poly_parser.send(:poly_parse, "2x"))
    assert_equal([[3, 1]], @poly_parser.send(:poly_parse, "x^3"))
    assert_equal([[4, 5]], @poly_parser.send(:poly_parse, "5x^4"))
    assert_equal([[1, -1]], @poly_parser.send(:poly_parse, "-x"))
    assert_equal([[0, -1]], @poly_parser.send(:poly_parse, "-1"))
    assert_equal([[1, -2]], @poly_parser.send(:poly_parse, "-2x"))
    assert_equal([[3, -1]], @poly_parser.send(:poly_parse, "-x^3"))
    assert_equal([[4, -5]], @poly_parser.send(:poly_parse, "-5x^4"))
  end

  def test_one_float_var
    assert_equal([[1, 5.8]], @poly_parser.send(:poly_parse, "5.8x"))
    assert_equal([[2, -5.8]], @poly_parser.send(:poly_parse, "-5.8x^2"))
    assert_equal([[0, 2.4]], @poly_parser.send(:poly_parse, "2.4"))
    assert_equal([[0, -2.4]], @poly_parser.send(:poly_parse, "-2.4"))
  end

  def test_same_power_vars
    assert_equal([[3, 5]], @poly_parser.send(:poly_parse, "2x^3+3x^3"))
    assert_equal([[1, 5]], @poly_parser.send(:poly_parse, "x+4x"))
    assert_equal([[2, 2.3]], @poly_parser.send(:poly_parse, "3.4x^2-1.1x^2"))
    assert_equal([[1, 2.4]], @poly_parser.send(:poly_parse, "6x-3.6x"))
    assert_equal([[2, 9.5]], @poly_parser.send(:poly_parse, "5x^2+4.5x^2"))
    assert_equal([[0, -8]], @poly_parser.send(:poly_parse, "10-18"))
  end

  def test_random_power_vars
    assert_equal([[1, 5], [2, 7]], @poly_parser.send(:poly_parse, "x+4x+7x^2"))
    assert_equal([[1, 4.5], [2, 8]], @poly_parser.send(:poly_parse, "x^2+4.5x+7x^2"))
    assert_equal([[0, -1], [1, 2]], @poly_parser.send(:poly_parse, "5-6+2x"))
    assert_equal([[0, -5], [7]], @poly_parser.send(:poly_parse, "2x+4+5x-9"))
  end
end
