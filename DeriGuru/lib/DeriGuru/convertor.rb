# frozen_string_literal: true

module DeriGuru
  # lass providing functionality for differentiating polynomials - converting part
  class PolyDiffer
    class << self
      private

      # @param [Array] array_of_ratio
      # @param [char] diff_var
      def convert(array_of_ratio, diff_var)
        str = ""
        added_elems = 0
        array_of_ratio.sort.reverse.each do |ratio|
          dg = ratio[0] # degree
          rt = ratio[1] # ratio
          lt = ratio[2] # letters
          sgn = rt.positive? ? "+" : "-"
          rt = rt.abs
          new_elem = ""
          next if rt.zero?

          new_elem += sgn if added_elems.positive? || (sgn == "-")
          new_elem += rt.to_s if (rt != 1) || (dg.zero? && (lt.nil? || (lt == "")))
          new_elem += lt unless lt.nil?
          if dg != 0
            new_elem += diff_var
            new_elem += "^#{dg}" if dg != 1
          end
          str += new_elem
          added_elems += 1
        end
        str
      end
    end
  end
end
