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

end