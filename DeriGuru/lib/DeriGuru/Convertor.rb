class PolyDiffer
    private
    # @param [Array] array_of_ratio
    # @param [char] diff_var
    def Convert (array_of_ratio, diff_var)
        str = ""
        added_elems = 0
        array_of_ratio.sort.reverse.each do |ratio|
            dg = ratio[0] # degree
            rt = ratio[1] # ratio
            lt = ratio[2] # letters
            sgn = rt > 0 ? "+" : "-"
            rt = rt.abs
            new_elem = ""
            unless rt == 0
                if added_elems > 0 or sgn == "-"
                    new_elem += sgn
                end
                if rt != 1 or (dg == 0 and (lt.nil? or lt == ""))
                    new_elem += rt.to_s
                end
                unless lt.nil?
                    new_elem += lt
                end
                if dg != 0
                    new_elem += diff_var
                    if dg != 1
                        new_elem += "^" + dg.to_s
                    end
                end
                str += new_elem
                added_elems += 1
            end
        end
        return str
    end
end
