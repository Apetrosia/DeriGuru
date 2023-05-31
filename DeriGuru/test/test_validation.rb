# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/DeriGuru/validation"
require_relative "../lib/exceptions"

# tests for validating input string
class TestValidation < Minitest::Test
  include DeriGuru

  def test_poly_differ_has_needed_method
    assert_respond_to PolyDiffer, :validation_check, is_private: true
  end

  # Tests without exceptions
  def test_no_var_digit
    assert_silent { PolyDiffer.send(:validation_check, "1", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-1", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "2.3", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-20.3", "x") }
  end

  def test_no_var_digits_operations
    assert_silent { PolyDiffer.send(:validation_check, "5+46", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "22-4", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "5.8+6.9", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "22.2-4.4", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-1.6-598", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-1001+9", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "3.3+6", "x") }
  end

  def test_one_variable
    assert_silent { PolyDiffer.send(:validation_check, "x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-x", "x") }
  end

  def test_one_variable_operation
    assert_silent { PolyDiffer.send(:validation_check, "x+x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x-x", "x") }
  end

  def test_one_var_with_coefs
    assert_silent { PolyDiffer.send(:validation_check, "2x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-2x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "2.2x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-2.9x", "x") }
  end

  def test_one_var_with_coefs_oper
    assert_silent { PolyDiffer.send(:validation_check, "4x+5x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "4x-5x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-4.98x-5.57x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "4.74x+57.98x", "x") }
  end

  def test_one_var_with_degree
    assert_silent { PolyDiffer.send(:validation_check, "x^0", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x^1", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x^2", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x^3", "x") }
  end

  def test_one_var_with_degree_oper
    assert_silent { PolyDiffer.send(:validation_check, "x^2+x^3", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x^2-x^3", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x^2+x^3+x^6", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-x^2-x^3-x^6", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-x^2+x^3-x^6", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x^2-x^3+x^6", "x") }
  end

  def test_one_var_deg_coefs_oper
    assert_silent { PolyDiffer.send(:validation_check, "12x^2+0x^3", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-1x^2-244x^3", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "2x^2+48x^3+712x^1", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "12x^2-164x^3-9x^6", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-12x^1+164x^3-9x^5", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "12x^2-164x^0+9x^6", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "12.678x^10+0.001x^3", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-1.2x^2-244.44x^16", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "2.2x^2+48.34x^3+712.0x^1", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-12.89x^2-164.18x^3-9.2x^4", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-12.87x^2+164.0x^3-9x^6+x-12", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "13.76+12.08x^2-164.0001x^3+913.9x^6-x", "x") }
  end

  def test_two_var_opers
    assert_silent { PolyDiffer.send(:validation_check, "x+y", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x-y", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "y-x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-x-y", "x") }
  end

  def test_two_var_opers_with_coefs
    assert_silent { PolyDiffer.send(:validation_check, "5*x+12*y", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "5*x-3*y", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "0*y-x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-x-9*y", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "0.12*x+87.9*y", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "13.0*x-98*y", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "1.1*y-x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-195.1*x-0.08y", "x") }
  end

  def test_two_var_opers_with_degree
    assert_silent { PolyDiffer.send(:validation_check, "x^1+y^3+x^2", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x^7+y^32+y^2", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x^7+y^32+y^2+x^4", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x^1-y^3+x^2", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x^7-y^32-y^2", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x^7-y^32+y^2-x^4", "x") }
  end

  def test_two_var_deg_and_coefs
    assert_silent { PolyDiffer.send(:validation_check, "y^32+3*y^2+9.8*x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "98*x^7+1.17*y^32+9*y^2-x^4", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "9*x^1-1*y^3+8*x^2", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "83.0*x^7-12.9*y^32-89.944*y^2", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "12.8*x^7-12.98*y^32+0*y^2-12.45*x^4", "x") }
  end

  def test_three_var_opers
    assert_silent { PolyDiffer.send(:validation_check, "x+y+z", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x-y-z", "x") }
  end

  def test_three_var_with_coefs
    assert_silent { PolyDiffer.send(:validation_check, "2*x+75*y+123.74*z", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "2*x-75*y-123.74*z", "x") }
  end

  def test_three_var_with_degree
    assert_silent { PolyDiffer.send(:validation_check, "x^3+y^1+z^2", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-x^3-y^1-z^2", "x") }
  end

  def test_three_var_deg_and_coefs
    assert_silent { PolyDiffer.send(:validation_check, "78.89*x^3+0*y^1+12*z^2", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "x^3+x^0+y^1+y^2+z^2+z^3", "x") }
    assert_silent do
      PolyDiffer.send(:validation_check, "-12*x^3-14.98*x^2+x+1*y^1+14.78*y^4+34*y^2-56.001*z^2-z+z^3", "x")
    end
  end

  def test_polynomials_with_spaces
    assert_silent { PolyDiffer.send(:validation_check, "-x^3 -y^1-z^2", "x") }
    assert_silent { PolyDiffer.send(:validation_check, " -x^3-y^1-z^2", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-x^3-y^1-z^2 ", "x") }
  end

  # Exceptions: - ArgumentError
  def test_non_string_arguments
    assert_raises(ArgumentError) { PolyDiffer.send(:validation_check, 1, 2) }
    assert_raises(ArgumentError) { PolyDiffer.send(:validation_check, "d", 2.8) }
    assert_raises(ArgumentError) { PolyDiffer.send(:validation_check, nil, "g") }
  end

  def test_empty_strings
    assert_raises(ArgumentError) { PolyDiffer.send(:validation_check, "", "") }
    assert_raises(ArgumentError) { PolyDiffer.send(:validation_check, "", "x") }
    assert_raises(ArgumentError) { PolyDiffer.send(:validation_check, "x", "") }
  end

  # Exceptions: - UnexpectedSymbolError

  def test_unexpected_symb_division
    assert_raises(UnexpectedSymbolError) { PolyDiffer.send(:validation_check, "x/x", "x") }
    assert_raises(UnexpectedSymbolError) { PolyDiffer.send(:validation_check, "12.95/34", "x") }
  end

  def test_unexpected_symb_bracket
    assert_raises(UnexpectedSymbolError) { PolyDiffer.send(:validation_check, "x^(-12-9)+x^(12-4)", "x") }
    assert_raises(UnexpectedSymbolError) { PolyDiffer.send(:validation_check, "x+(x-y)", "x") }
  end

  def test_unexpected_symb_rand
    assert_raises(UnexpectedSymbolError) { PolyDiffer.send(:validation_check, "x^7+x^0!", "x") }
    assert_raises(UnexpectedSymbolError) { PolyDiffer.send(:validation_check, "1<5+x>y", "x") }
  end

  def test_unexpected_symbols_for_second_arg
    assert_raises(UnexpectedSymbolError) { PolyDiffer.send(:validation_check, "x^7+x^0", "9") }
    assert_raises(UnexpectedSymbolError) { PolyDiffer.send(:validation_check, "x", ")") }
    assert_raises(UnexpectedSymbolError) { PolyDiffer.send(:validation_check, "x", "W") }
    assert_raises(UnexpectedSymbolError) { PolyDiffer.send(:validation_check, "x", "ы") }
  end

  #  Exceptions: IncorrectSymbolError

  def test_wrong_placed_symbol_prod
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "x^2*x^3*x^6", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "x*x", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "6*6", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "6*7*x^2+x", "x") }
  end

  def test_wrong_placed_symb_duplcts
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "x++x", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "x--x", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "4.2**x", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "4..02x", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "x^^3", "x") }
  end

  def test_wrong_placed_symbol
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "x+-x", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "x-+x", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "x^-4+x", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "x9-3+y", "x") }
  end

  def test_several_vars
    assert_silent { PolyDiffer.send(:validation_check, "2xy+3yx", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "2xy+3yx", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "2xz*y+3z*yx", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "2x^3y+3y^5x", "x") }
    assert_silent { PolyDiffer.send(:validation_check, "-2x^4y^15 + 3y^67*x^12", "x") }
  end

  def test_wrong_several_vars
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "x2y", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "2x^^2", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "2x^", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "2x^y", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "2xyy", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "2xy^y", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "2xy5", "x") }
    assert_raises(IncorrectSymbolError) { PolyDiffer.send(:validation_check, "-2x^4y^15+ 3y^6*7*x^12", "x") }
  end
end
