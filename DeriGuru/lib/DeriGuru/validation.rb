# frozen_string_literal: true

module DeriGuru
  # class providing functionality for differentiating polynomials - validation part
  class PolyDiffer
    private

    # TODO: implement validation
    def validation_check(poly_string)
      poly_string = "+" + poly_string unless "+-".include?(poly_string[0])

=begin
      sign = /[+-]/
      coef = /(\d+(\.\d+)?)?/
      multi_sign = /\*?/
      variables = /((?<var>[a-z])(\^\d+)?\*?)*/
      pattern = sign + coef + multi_sign + variables # [+-](\d+(\.\d+)?)?\*?((?<var>[a-z])(\^\d+)?\*?)*
=end

      pattern = /^(
                 [+-]
                 (\d+(\.\d+)?)?
                 \*?
                 ((?<var>[a-z])(\^\d+)?\*?)*
                 )+$/x

      raise StandardError if ((poly_string =~ pattern) == nil)
    end
  end
end
