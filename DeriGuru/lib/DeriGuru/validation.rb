# frozen_string_literal: true

module DeriGuru
  # class providing functionality for differentiating polynomials - validation part
  class PolyDiffer
    private

    def validation_check(poly_string)
      md = poly_string.match(/[^a-z+\-*.^\d\s]/)
      raise UnexpectedSymbolError, "Input string contains unexpected symbol: #{md[0]}" if md != nil

      copy = "+-".include?(poly_string[0]) ? poly_string : "+" + poly_string
      copy = copy.strip
      # [+-](\d+(\.\d+)?)?\*?((?<var>[a-z])(\^\d+)?\*?)*
      pattern = /^(
                 [+-]\s*(?![+-])          # sign before term
                 (\d+(\.\d+)?)?\s*        # coefficient
                 \*?\s*                   # multiply sign
                 ([a-z](\^\d+)?\*?)*\s*   # variables
                 )+$/x

      raise IncorrectSymbolError, "You passed invalid polynomial to the method" if copy.match(pattern) == nil || copy[-1] == "*"

      copy.split(/[+-]/).each do |term|
        vars = term.scan(/[a-z]/)
        raise IncorrectSymbolError, "Multiple similar variables in one term are not allowed" if vars.size > vars.uniq.size
      end

    end
  end
end
