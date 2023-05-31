# frozen_string_literal: true

require_relative "lib/DeriGuru/version"

Gem::Specification.new do |spec|
  spec.name = "DeriGuru"
  spec.version = DeriGuru::VERSION
  spec.authors = ["Елизавета Домбаян", "Александр Земляк", "Нарек Казоян", "Анна Петросян", "Виктория Хоружая"]
  spec.email = ["apetrosia@sfedu.ru"]

  spec.summary = "Gem for symbolic differentiation of polynomials"
  spec.description = "Gem for symbolic differentiation of polynomials containing only integers or
                      fractional numbers and variables."
  spec.homepage = "https://github.com/Apetrosia/DeriGuru"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"


  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
