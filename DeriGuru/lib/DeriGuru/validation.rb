# frozen_string_literal: true

module DeriGuru
  # class providing functionality for differentiating polynomials - validation part
  class PolyDiffer
    private

    def self.validation_check(poly_string, diff_var)
      raise ArgumentError, "Arguments should be of string type" if poly_string.class != String ||
                                                                   diff_var.class != String

      raise ArgumentError, "Polynomial string is empty" if poly_string.empty?
      raise ArgumentError, "Differentiation variable string is empty" if diff_var.empty?

      md = poly_string.match(/[^a-z+\-*.^\d\s]/)
      raise UnexpectedSymbolError, "Input string contains unexpected symbol: #{md[0]}" unless md.nil?

      if diff_var.length > 1 ||
         diff_var.match(/[a-z]/).nil?
        raise UnexpectedSymbolError,
              "Differentiation variable should be a lowercase latin letter"
      end

      copy = "+-".include?(poly_string[0]) ? poly_string : "+#{poly_string}"
      copy = copy.strip

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
