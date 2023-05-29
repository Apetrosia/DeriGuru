# frozen_string_literal: false

module DeriGuru
  # class providing functionality for differentiating polynomials - parsing part
  class PolyDiffer
    private

    def poly_parse(str, val)
      terms = []
      return terms if str.empty?

      str = str.gsub(" ", "")
      str = str.gsub("*", "")
      str = str.gsub("-", "+-")
      arr = str.split("+")
      arr.each do |term|
        next unless term != ""

        other_vars = []
        m = term.match(/\A[-0-9.]*/)
        coefficient = case m.to_s
                      when ""
                        1
                      when "-"
                        -1
                      else
                        m.to_s.to_f
                      end
        degree = 0
        term.scan(/[a-z]\^*\d*/) do |deg|
          s_deg = deg.to_s
          if s_deg.include?(val)
            degree = if s_deg == val
                       1
                     else
                       s_deg.sub("#{val}^", "").to_i
                     end
          else
            other_vars.push(s_deg)
          end
        end
        other_vars = other_vars.sort * ""
        if (find_term = terms.find { |elem| elem[0] == degree && elem[2] == other_vars})
          coefficient += find_term[1]
          terms.delete(find_term)
        end
        coefficient = coefficient.to_i if (coefficient - coefficient.to_i).abs < Float::EPSILON
        trio = [degree, coefficient, other_vars]
        terms.push(trio)
      end
      terms.sort
    end
  end
end

