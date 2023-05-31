# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/DeriGuru/differentiation"

# tests for differentiation
class TestConvertor < Minitest::Test
  include DeriGuru

  def setup
    @poly_differ = PolyDiffer.new
  end

  def test_poly_differ_has_needed_method
    assert_respond_to @poly_differ, :differentiate, is_private: false
  end

  def test_differentiation_for_int_var
    assert_equal "1", @poly_differ.send(:differentiate, "x", "x")
    assert_equal "", @poly_differ.send(:differentiate, "1", "x")
    assert_equal "", @poly_differ.send(:differentiate, "154678+1241+12-12125+45-10000000", "x")
    assert_equal "", @poly_differ.send(:differentiate, "x^0", "x")

    assert_equal "2x", @poly_differ.send(:differentiate, "x^2", "x")
    assert_equal "-2x", @poly_differ.send(:differentiate, "-x^2", "x")

    assert_equal "3x^2", @poly_differ.send(:differentiate, "x^3", "x")
    assert_equal "-3x^2", @poly_differ.send(:differentiate, "-x^3", "x")

    assert_equal "4x", @poly_differ.send(:differentiate, "2x^2", "x")
    assert_equal "-4x", @poly_differ.send(:differentiate, "-2x^2", "x")

    assert_equal "3x^2+6", @poly_differ.send(:differentiate, "x^3+6x", "x")
    assert_equal "-3x^2+6", @poly_differ.send(:differentiate, "-x^3+6x", "x")
    assert_equal "-3x^2-6", @poly_differ.send(:differentiate, "-x^3-6x", "x")

    assert_equal "-3x^2+6x", @poly_differ.send(:differentiate, "-x^3+3x^2", "x")
    assert_equal "3x^2-6x", @poly_differ.send(:differentiate, "x^3-3x^2", "x")

    assert_equal "25x^4+16x^3-18x^2-8x+18", @poly_differ.send(:differentiate, "5x^5+4x^4-6x^3-4x^2+18x+100000000", "x")
    assert_equal "25x^4+8x+18", @poly_differ.send(:differentiate, "5x^5+4x^2+18x+1098712419870000000", "x")
  end

  def test_differentiation_for_double_var
    assert_equal "8.4x", @poly_differ.send(:differentiate, "4.2x^2", "x")
    assert_equal "-2.2x", @poly_differ.send(:differentiate, "-1.1x^2", "x")

    assert_equal "7.5x^2", @poly_differ.send(:differentiate, "2.5x^3", "x")
    assert_equal "-1.5x^2", @poly_differ.send(:differentiate, "-0.5x^3", "x")

    assert_equal "4x+1.5", @poly_differ.send(:differentiate, "2x^2+1.5x", "x")
    assert_equal "-4x", @poly_differ.send(:differentiate, "-2x^2+4.2", "x")

    assert_equal "15x^2+6.2", @poly_differ.send(:differentiate, "5.0x^3+6.2x", "x")

    assert_equal "-0.6x^2+6.9", @poly_differ.send(:differentiate, "-0.2x^3+6.9x", "x")
    assert_equal "-38.1x^2-6", @poly_differ.send(:differentiate, "-12.7x^3-6x", "x")
    assert_equal "-6.3x^2+7x", @poly_differ.send(:differentiate, "-2.1x^3+3.5x^2", "x")
    assert_equal "-333.33x^2-6x", @poly_differ.send(:differentiate, "-111.11x^3-3x^2", "x")
    assert_equal "25.5x^4+16.1x^3-18x^2-9x+18.9",
                 @poly_differ.send(:differentiate, "5.1x^5+4.025x^4-6x^3-4.5x^2+18.9x+100000000", "x")
    assert_equal "27x^4+9.2x+18", @poly_differ.send(:differentiate, "5.4x^5+4.6x^2+18x+1098712419870000000", "x")
  end

  def test_differentiation_for_multiple_variables
    assert_equal "-zx^3+2.22yzx^2+8x-7y", @poly_differ.send(:differentiate, "0.74x^3yz-0.25x^4z+4x^2-7xy", "x")
    assert_equal "6yx^3", @poly_differ.send(:differentiate, "1.5x^4y", "x")
    assert_equal "yz", @poly_differ.send(:differentiate, "xyz", "x")
    assert_equal "-zx^3+2.25yzx^2+8x-7y", @poly_differ.send(:differentiate, "0.75x^3yz-0.25x^4z+4x^2-7xy", "x")
  end
end
