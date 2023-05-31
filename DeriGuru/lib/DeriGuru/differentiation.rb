# frozen_string_literal: true

require_relative "convertor"
require_relative "deri_calculation"
require_relative "deri_parser"
require_relative "validation"

module DeriGuru
  # class providing functionality for differentiating polynomials - main function for differentiating
  class PolyDiffer
    class << self
      # Differentiates a polynomial
      # @param [String] poly_str
      # @param [String] diff_var
      # @return [String] differentiated polynomial
      def differentiate(poly_str, diff_var)
        validation_check(poly_str, diff_var)
        poly_parsed = poly_parse(poly_str, diff_var)
        poly_diff = calculate_derivative(poly_parsed)
        convert(poly_diff, diff_var)
      end
    end
  end
end
