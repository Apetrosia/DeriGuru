# frozen_string_literal: true

module DeriGuru
  # Basic DeriGuru error class
  class DeriGuruError < StandardError; end

  # Error during validation
  class PolyValidationError < DeriGuruError; end

  # Symbol met wasn't a digit or operation
  class UnexpectedSymbolError < PolyValidationError; end

  # Acceptable symbol is used incorrectly
  class IncorrectSymbolError < PolyValidationError; end
end
