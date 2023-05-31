# frozen_string_literal: true

require_relative "test_helper"

# Basic gem tests
class TestDeriGuru < Minitest::Test
  def test_has_a_version_number
    refute_nil ::DeriGuru::VERSION
  end
end
