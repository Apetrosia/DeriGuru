# frozen_string_literal: true

module DeriGuru
  # class providing functionality for differentiating polynomials - validation part
  class PolyDiffer
    private

    # TODO: implement validation
    def validation_check(poly_string)
      raise ArgumentError, "Input string contains forbidden symbol" if poly_string.match(/[^a-z+\-*.^\d\s]/) != nil
      copy = "+-".include?(poly_string[0]) ? poly_string : "+" + poly_string
      copy = copy.strip
      # [+-](\d+(\.\d+)?)?\*?((?<var>[a-z])(\^\d+)?\*?)*
      pattern = /^(
                 [+-]\s*                  # sign before term
                 (\d+(\.\d+)?)?\s*        # coefficient
                 \*?\s*                   # multiply sign
                 ([a-z](\^\d+)?\*?)*\s*   # variables
                 )+$/x

      raise ArgumentError, "You passed invalid polynomial to the method" if copy.match(pattern) == nil || copy[-1] == "*"

      copy.split(/[+-]/).each do |term|
        vars = term.scan(/[a-z]/)
        raise ArgumentError, "Multiple similar variables in one term are not allowed" if vars.size > vars.uniq.size
      end

    end
  end
end
