# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/DeriGuru/Convertor"

# tests for derivative calculating stage
class TestConvertor < Minitest::Test
  include DeriGuru

  def setup
    @poly_conv = Convert.new
  end

  def test_poly_convertor_has_needed_method
    assert_respond_to @poly_conv, :Convert, is_private: true
  end

  def test_empty_data
    #нужно исключение выкинуть
    #нужен ассерт райз для ошибок
    assert_equal "", @poly_conv.send(:Convert,[],"x")
    assert_equal "", @poly_conv.send(:Convert,[[1,2],[5,2]],"")
  end

  def test_deri_convertor
    #предположим их нет или  это исключение
    assert_equal "", @poly_conv.send(:Convert,[[1,0]],"x")        
    assert_equal "1", @poly_conv.send(:Convert,[[0,1]],"x")
    assert_equal "x", @poly_conv.send(:Convert,[[1,1]],"x")
    assert_equal "2x", @poly_conv.send(:Convert,[[1,2]],"x")
    assert_equal "2x^3", @poly_conv.send(:Convert,[[3,2]],"x")
    assert_equal "2x^3+x", @poly_conv.send(:Convert,[[1,1],[3,2]],"x")
    assert_equal "-2x^3", @poly_conv.send(:Convert,[[3,-2]],"x")
    assert_equal "-2x^(-3)", @poly_conv.send(:Convert,[[-3,-2]],"x")
    assert_equal "-2x^3+15x^2-x", @poly_conv.send(:Convert,[[1,-1],[2,15],[3,-2]],"x")
  end

end
