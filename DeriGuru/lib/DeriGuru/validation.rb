# frozen_string_literal: true

module DeriGuru
  # class providing functionality for differentiating polynomials - validation part
  class PolyDiffer
    private

    def validation_check(poly_string)
      md = poly_string.match(/[^a-z+\-*.^\d\s]/)
      raise UnexpectedSymbolError, "Input string contains unexpected symbol: #{md[0]}" unless md.nil?

      copy = "+-".include?(poly_string[0]) ? poly_string : "+#{poly_string}"
      copy = copy.strip
      # [+-](\d+(\.\d+)?)?\*?((?<var>[a-z])(\^\d+)?\*?)*
      pattern = /^(
                 [+-]\s*(?![+-])          # sign before term
                 (\d+(\.\d+)?)?\s*        # coefficient
                 \*?\s*                   # multiply sign
                 ([a-z](\^\d+)?\*?)*\s*   # variables
                 )+$/x

      if copy.match(pattern).nil? || copy[-1] == "*"
        raise IncorrectSymbolError,
              "You passed invalid polynomial to the method"
      end

      copy.split(/[+-]/).each do |term|
        vars = term.scan(/[a-z]/)
        if vars.size > vars.uniq.size
          raise IncorrectSymbolError,
                "Multiple similar variables in one term are not allowed"
        end
      end
    end
  end
end
