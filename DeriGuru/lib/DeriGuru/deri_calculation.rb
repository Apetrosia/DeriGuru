# frozen_string_literal: true

module DeriGuru
  # class providing functionality for differentiating polynomials - derivative calculation part
  class PolyDiffer
    private

    
    def calculate_derivative(poly)
      if (!poly.nil?)
        poly.delete_if {|term| term[0] == 0 }

        poly.each do |term|
          term[1] = term[0] * term[1]
          term[0] -= 1    
        end

      end
      poly
    end
  end
end
