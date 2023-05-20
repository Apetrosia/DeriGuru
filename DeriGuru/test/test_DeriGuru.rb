# frozen_string_literal: true

require "test_helper"

# Basic gem tests
class TestDeriGuru < Minitest::Test
  def test_has_a_version_number
    refute_nil ::DeriGuru::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
