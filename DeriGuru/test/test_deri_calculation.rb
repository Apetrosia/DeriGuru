# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/DeriGuru/deri_calculation"

# tests for derivative calculating stage
class TestDeriCalculation < Minitest::Test
  include DeriGuru

  def setup
    @poly_differ = PolyDiffer.new
  end

  def test_poly_differ_has_needed_method
    assert_respond_to @poly_differ, :calculate_derivative, is_private: true
  end

  def test_deri_calculation_monomials
    # test with monomial - power > 0
    poly = [[4, 100]]
    expected = [[3, 400]]

    assert_equal expected, @poly_differ.send(:calculate_derivative, poly)

    # test with monomial - power = 0
    poly = [[0, 10]]
    expected = []

    assert_equal expected, @poly_differ.send(:calculate_derivative, poly)
  end

  def test_deri_calculation_polynoms
    # test with consecutive powers
    poly = [[0, 10], [1, 2], [2, -5]]
    expected = [[0, 2], [1, -10]]

    assert_equal expected, @poly_differ.send(:calculate_derivative, poly)

    # test with not consecutive powers
    poly = [[1, -3], [5, 12]]
    expected = [[0, -3], [4, 60]]

    assert_equal expected, @poly_differ.send(:calculate_derivative, poly)

    # test with a bigger poly
    poly = [[3, 239], [5, -25], [8, 1], [10, -85], [12, 50]]
    expected = [[2, 717], [4, -125], [7, 8], [9, -850], [11, 600]]

    assert_equal expected, @poly_differ.send(:calculate_derivative, poly)
  end

  def test_deri_calculation_real_coefs
    # test with one remaining real coefficient
    poly = [[0, 9.212], [2, -0.25]]
    expected = [[1, -0.5]]
    result = @poly_differ.send(:calculate_derivative, poly)

    assert_polynomials_in_delta expected, result

    # test with monomial - power = 0
    poly = [[0, 12.3423]]
    expected = []
    result = @poly_differ.send(:calculate_derivative, poly)

    assert_equal expected, result

    # test with bigger numbers
    poly = [[5, 10.992], [7, -923.835], [15, 23.684_4], [10_000, -5_823.573_585_6], [23_493, 95.0]]
    expected = [[4, 54.96], [6, -6_466.845], [14, 355.266], [9_999, 58_235_735.856], [23_492, 2_231_835.0]]
    result = @poly_differ.send(:calculate_derivative, poly)

    assert_polynomials_in_delta expected, result
  end
end
