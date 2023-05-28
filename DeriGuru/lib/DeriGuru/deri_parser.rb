# frozen_string_literal: false

module DeriGuru
  # class providing functionality for differentiating polynomials - parsing part
  class PolyDiffer
    private

    def poly_parse(str, val)
      terms = Array.new{}
      return terms if str.empty?

      str = str.gsub(" ", "")
      str = str.gsub("-", "+-")
      arr = str.split("+")
      arr.each do |term|
        next unless term != ""

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
        if term.include?(val)
          deg = term.match(/\^\d+/)
          degree = if deg.to_s == ""
                     1
                   else
                     deg.to_s.sub("^", "").to_i
                   end
        end
        if (find_term = terms.find { |elem| elem[0] == degree })
          coefficient += find_term[1]
          terms.delete(find_term)
        end
        coefficient = coefficient.to_i if (coefficient - coefficient.to_i).abs < Float::EPSILON
        trio = [degree, coefficient, ""]
        terms.push(trio)
      end
      terms.sort
    end
  end
end

