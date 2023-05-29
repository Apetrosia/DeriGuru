module DeriGuru
  # class providing functionality for differentiating polynomials - differentiation part
  class PolyDiffer
    public
    # Differentiates a polynomial
    # @param [String] poly_str
    # @param [String] diff_var
    # @return [String] differentiated polynomial
    def differentiate(poly_str, diff_var)
      validation_check(poly_str)
      poly_parsed = poly_parse(poly_str, diff_var)
      poly_diff = calculate_derivative(poly_parsed)
      poly_converted = Convert(poly_diff, diff_var)
      return poly_converted
    end
  end
end