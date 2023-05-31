# frozen_string_literal: true

module DeriGuru
  # class providing functionality for differentiating polynomials - derivative calculation part
  class PolyDiffer
    private

    # @param [Array] poly
    # return [Array] poly
    def self.calculate_derivative(poly)
      unless poly.nil?
        poly.delete_if { |term| (term[0]).zero? }
        poly.each do |term|
          term[1] = (term[0] * term[1]).round(10)
          term[1] = term[1].to_i if (term[1] - term[1].to_i).abs < Float::EPSILON
          term[0] -= 1
        end
      end
      poly
    end
  end
end
