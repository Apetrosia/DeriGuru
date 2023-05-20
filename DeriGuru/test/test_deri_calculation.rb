# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/DeriGuru/deri_calculation"
class TestDeriCalculation < Minitest::Test
  include DeriGuru

  def test_deri_calculation_monomials
    # test with monomial - power > 0
    poly = [[4, 100]]
    expected = [[3, 400]]

    assert_equal expected, calculate_derivative(poly)

    # test with monomial - power = 0
    poly = [[0, 10]]
    expected = []

    assert_equal expected, calculate_derivative(poly)
  end

  def test_deri_calculation_polynoms
    # test with consecutive powers
    poly = [[0, 10], [1, 2], [2, -5]]
    expected = [[0, 2], [1, -10]]

    assert_equal expected, calculate_derivative(poly)

    # test with not consecutive powers
    poly = [[1, -3], [5, 12]]
    expected = [[0, -3], [4, 60]]

    assert_equal expected, calculate_derivative(poly)

    # test with a bigger poly
    poly = [[3, 239], [5, -25], [8, 1], [10, -85], [12, 50]]
    expected = [[2, 717], [4, -125], [7, 8], [9, -850], [11, 600]]

    assert_equal expected, calculate_derivative(poly)
  end
end
