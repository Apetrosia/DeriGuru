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
    assert_equal @poly_parser.send(:poly_parse, ""), []
  end

  def test_one_int_var
    assert_equal @poly_parser.send(:poly_parse, "x"), [[1, 1]]
    assert_equal @poly_parser.send(:poly_parse, "1"), [[0, 1]]
    assert_equal @poly_parser.send(:poly_parse, "2x"), [[1, 2]]
    assert_equal @poly_parser.send(:poly_parse, "x^3"), [[3, 1]]
    assert_equal @poly_parser.send(:poly_parse, "5x^4"), [[4, 5]]
    assert_equal @poly_parser.send(:poly_parse, "-x"), [[1, -1]]
    assert_equal @poly_parser.send(:poly_parse, "-1"), [[0, -1]]
    assert_equal @poly_parser.send(:poly_parse, "-2x"), [[1, -2]]
    assert_equal @poly_parser.send(:poly_parse, "-x^3"), [[3, -1]]
    assert_equal @poly_parser.send(:poly_parse, "-5x^4"), [[4, -5]]
  end

  def test_one_float_var
    assert_equal @poly_parser.send(:poly_parse, "5.8x"), [[1, 5.8]]
    assert_equal @poly_parser.send(:poly_parse, "-5.8x"), [[1, -5.8]]
    assert_equal @poly_parser.send(:poly_parse, "2.4"), [[0, 2.4]]
    assert_equal @poly_parser.send(:poly_parse, "-2.4"), [[0, -2.4]]
  end
end