# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/DeriGuru/validation"

class TestDeriCalculation < Minitest::Test
  include DeriGuru
  # Tests without exceptions
  # Tests without exceptions for poly with no variable
  def test_no_var_int_digit
    assert_silent { validation_check("1") }
  end
  def test_no_var_neg_int_digit
    assert_silent { validation_check("-1") }
  end
  def test_no_var_double_digit
    assert_silent { validation_check("2.3") }
  end
  def test_no_var_neg_double_digit
    assert_silent { validation_check("-20.3") }
  end
  # tests integers operations
  def test_no_var_int_with_plus
    assert_silent { validation_check("5+46") }
  end
  def test_no_var_int_with_minus
    assert_silent { validation_check("22-4") }
  end
  def test_no_var_int_with_div
    assert_silent { validation_check("9/612") }
  end
  def test_no_var_int_with_prod
    assert_silent { validation_check("8*8") }
  end
  # test double with operations
  def test_no_var_double_with_plus
    assert_silent { validation_check("5.8+6.9") }
  end
  def test_no_var_double_with_minus
    assert_silent { validation_check("22.2-4.4") }
  end
  def test_no_var_double_with_div
    assert_silent { validation_check("9.8/644.444") }
  end
  def test_no_var_double_with_prod
    assert_silent { validation_check("8.811*8.8") }
  end
  # Test with negative digits
  def test_no_var_neg_case1
    assert_silent { validation_check("-1.6-598") }
  end
  def test_no_var_neg_case2
    assert_silent { validation_check("-1001+9") }
  end
  def test_no_var_neg_case3
    assert_silent { validation_check("-6.9/5") }
  end
  def test_no_var_neg_case4
    assert_silent { validation_check("-6/-52.7") }
  end
  def test_no_var_neg_case5
    assert_silent { validation_check("-6.6*5") }
  end
  def test_no_var_neg_case6
    assert_silent { validation_check("-6*-5.0") }
  end
  def test_no_var_mixed_expression1
    assert_silent { validation_check("3.3+6") }
  end
  def test_no_var_mixed_expression2
    assert_silent { validation_check("3+6.8-2*7+8/4") }
  end
  def test_no_var_mixed_expression3
    assert_silent { validation_check("3+6.9*9.12*0") }
  end
  def test_no_var_mixed_expression4
    assert_silent { validation_check("93.21/0-12-12/0.123") }
  end
  def test_no_var_mixed_expression5
    assert_silent { validation_check("0.123/0.345/0.278") }
  end
  def test_no_var_mixed_expression6
    assert_silent { validation_check("0.123*-0.345*0.278") }
  end

  # Tests without exceptions for poly with one variable
  def test_one_variable_simple
    assert_silent { validation_check("x") }
  end
  #  Tests without exceptions for poly with one variable
  #  Tests without exceptions for poly with two variable
  #  Tests without exceptions for poly with three variable

  #  Tests about unexpected symbols

  #  Tests about wrong symbol seq

  #  Tests about

end