# frozen_string_literal: true

module DeriGuru
  # class providing functionality for differentiating polynomials - derivative calculation part
  class PolyDiffer
    private

    def calculate_derivative(poly)
      if (!poly.nil?)
        for i in poly do
          for j in i do
            poly[i][1] = poly[i][0] * poly[i][1]
            poly[i][0]--
          end
        end
      end
      poly
    end
  end
end
