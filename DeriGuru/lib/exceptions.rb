# frozen_string_literal: true

module DeriGuru
  # Basic DeriGuru exception class
  class DeriGuruError < StandardError
    def to_s
      'Failed to differentiate a polynomial'
    end
  end

  #TODO: implement specific exceptions
end