# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/DeriGuru/validation"

class TestDeriCalculation < Minitest::Test
  include DeriGuru

  # Tests without exceptions
  def test_no_var_digit
    assert_silent { validation_check("1") }
    assert_silent { validation_check("-1") }
    assert_silent { validation_check("2.3") }
    assert_silent { validation_check("-20.3") }
  end

  def test_no_var_digits_operations
    assert_silent { validation_check("5+46") }
    assert_silent { validation_check("22-4") }
    assert_silent { validation_check("5.8+6.9") }
    assert_silent { validation_check("22.2-4.4") }
    assert_silent { validation_check("-1.6-598") }
    assert_silent { validation_check("-1001+9") }
    assert_silent { validation_check("3.3+6") }
  end

  def test_one_variable
    assert_silent { validation_check("x") }
    assert_silent { validation_check("-x") }
  end

  def test_one_variable_operation
    assert_silent { validation_check("x+x") }
    assert_silent { validation_check("x-x") }
  end

  def test_one_var_with_coeffitient
    assert_silent { validation_check("2*x") }
    assert_silent { validation_check("-2*x") }
    assert_silent { validation_check("2.2*x") }
    assert_silent { validation_check("-2.9*x") }
  end

  def test_one_var_with_coef_oper
    assert_silent { validation_check("4*x+5*x") }
    assert_silent { validation_check("4*x-5*x") }
    assert_silent { validation_check("-4.98*x-5.57*x") }
    assert_silent { validation_check("4.74*x+57.98*x") }
  end

  def test_one_var_with_degree
    assert_silent { validation_check("x^0") }
    assert_silent { validation_check("x^1") }
    assert_silent { validation_check("x^2") }
    assert_silent { validation_check("x^3") }
  end

  def test_one_var_with_degree_oper
    assert_silent { validation_check("x^2+x^3") }
    assert_silent { validation_check("x^2-x^3") }
    assert_silent { validation_check("x^2+x^3+x^6") }
    assert_silent { validation_check("-x^2-x^3-x^6") }
    assert_silent { validation_check("-x^2+x^3-x^6") }
    assert_silent { validation_check("x^2-x^3+x^6") }
  end

  def test_one_var_deg_coefs_oper
    assert_silent { validation_check("12*x^2+0*x^3") }
    assert_silent { validation_check("-1*x^2-244*x^3") }
    assert_silent { validation_check("2*x^2+48*x^3+712*x^1") }
    assert_silent { validation_check("12*x^2-164*x^3-9*x^6") }
    assert_silent { validation_check("-12*x^1+164*x^3-9*x^5") }
    assert_silent { validation_check("12*x^2-164*x^0+9*x^6") }
    assert_silent { validation_check("12.678*x^10+0.001*x^3") }
    assert_silent { validation_check("-1.2*x^2-244.44*x^16") }
    assert_silent { validation_check("2.2*x^2+48.34*x^3+712.0*x^1") }
    assert_silent { validation_check("-12.89*x^2-164.18*x^3-9.2*x^4") }
    assert_silent { validation_check("-12.87*x^2+164.0*x^3-9*x^6") }
    assert_silent { validation_check("12.08*x^2-164.0001*x^3+913.9*x^6") }
  end

  def test_two_var_opers
    assert_silent { validation_check("x+y") }
    assert_silent { validation_check("x-y") }
    assert_silent { validation_check("y-x") }
    assert_silent { validation_check("-x-y") }
  end

  def test_two_var_opers_with_coefs
    assert_silent { validation_check("5*x+12*y") }
    assert_silent { validation_check("5*x-3*y") }
    assert_silent { validation_check("0*y-x") }
    assert_silent { validation_check("-x-9*y") }
    assert_silent { validation_check("0.12*x+87.9*y") }
    assert_silent { validation_check("13.0*x-98*y") }
    assert_silent { validation_check("1.1*y-x") }
    assert_silent { validation_check("-195.1*x-0.08y") }
  end

  def test_two_var_opers_with_degree
    assert_silent { validation_check("x^1+y^3+x^2") }
    assert_silent { validation_check("x^7+y^32+y^2") }
    assert_silent { validation_check("x^7+y^32+y^2+x^4") }
    assert_silent { validation_check("x^1-y^3+x^2") }
    assert_silent { validation_check("x^7-y^32-y^2") }
    assert_silent { validation_check("x^7-y^32+y^2-x^4") }
  end

  def test_two_var_deg_and_coefs
    assert_silent { validation_check("y^32+3*y^2+9.8*x") }
    assert_silent { validation_check("98*x^7+1.17*y^32+9*y^2-x^4") }
    assert_silent { validation_check("9*x^1-1*y^3+8*x^2") }
    assert_silent { validation_check("83.0*x^7-12.9*y^32-89.944*y^2") }
    assert_silent { validation_check("12.8*x^7-12.98*y^32+0*y^2-12.45*x^4") }
  end

  def test_three_var_opers
    assert_silent { validation_check("x+y+z") }
    assert_silent { validation_check("x-y-z") }
  end

  def test_three_var_with_coefs
    assert_silent { validation_check("2*x+75*y+123.74*z") }
    assert_silent { validation_check("2*x-75*y-123.74*z") }
  end

  def test_three_var_with_degree
    assert_silent { validation_check("x^3+y^1+z^2") }
    assert_silent { validation_check("-x^3-y^1-z^2") }
  end

  def test_three_var_deg_and_coefs
    assert_silent { validation_check("78.89*x^3+0*y^1+12*z^2") }
    assert_silent { validation_check("x^3+x^0+y^1+y^2+z^2+z^3") }
    assert_silent { validation_check("-12*x^3-14.98*x^2+x+1*y^1+14.78*y^4+34*y^2-56.001*z^2-z+z^3") }
  end

  # Исключения: - неоджиданный(запрещённый) символ

  def test_unexpected_symb_division
    assert_raises(StandardError) { validation_check("x/x") }
    assert_raises(StandardError) { validation_check("12.95/34") }
  end

  def test_unexpected_symb_space
    assert_silent { validation_check("-x^3 -y^1-z^2") }
  end

  def test_unexpected_symb_bracket
    assert_raises(StandardError) { validation_check("x^(-12-9)+x^(12-4)") }
    assert_raises(StandardError) { validation_check("x+(x-y)") }
  end

  def test_unexpected_symb_rand
    assert_raises(StandardError) { validation_check("x^7+x^0!") }
    assert_raises(StandardError) { validation_check("1<5+x>y") }
  end

  #  Exception - неправильно употреблён символ

  def test_wrong_placed_symbol_prod
    assert_raises(StandardError) { validation_check("x^2*x^3*x^6") }
    assert_raises(StandardError) { validation_check("x*x") }
    assert_raises(StandardError) { validation_check("6*6") }
    assert_raises(StandardError) { validation_check("6*7*x^2+x") }
  end

  def test_wrong_placed_symb_duplicts
    assert_raises(StandardError) { validation_check("x++x") }
    assert_raises(StandardError) { validation_check("x--x") }
    assert_raises(StandardError) { validation_check("4.2**x") }
    assert_raises(StandardError) { validation_check("4..02*x") }
    assert_raises(StandardError) { validation_check("x^^3") }
  end

  def test_wrong_placed_symb_letters
    assert_raises(StandardError) { validation_check("2*x+xy") }
    assert_raises(StandardError) { validation_check("hello") }
  end

  def test_wrong_placed_symbol
    assert_raises(StandardError) { validation_check("x+-x") }
    assert_raises(StandardError) { validation_check("x-+x") }
    assert_raises(StandardError) { validation_check("x^-4+x") }
    assert_raises(StandardError) { validation_check("4x^3") }
    assert_raises(StandardError) { validation_check("x9-3+y") }
  end
end
