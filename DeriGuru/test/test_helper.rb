# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "DeriGuru"

require "minitest/autorun"


module Minitest
  # adding custom functionality to Minitest::Test standard class
  class Test
    # check for object responding to a method which can be private
    def assert_respond_to(obj, meth, is_private: false, msg: nil)
      msg = message(msg) do
        "Expected #{mu_pp(obj)} (#{obj.class}) to respond to ##{meth}"
      end

      assert obj.respond_to?(meth, is_private), msg
    end

    def assert_arrays_in_delta(expected, actual, msg = nil)
      expected.zip(actual).each { |x, y| assert_in_delta x, y, msg }
    end

    def assert_polynomials_in_delta(expected, actual, msg = nil)
      expected.zip(actual).each { |pair1, pair2| assert_arrays_in_delta pair1, pair2, msg }
    end
  end
end
