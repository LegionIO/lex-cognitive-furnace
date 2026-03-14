# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_furnace/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-cognitive-furnace'
  spec.version       = Legion::Extensions::CognitiveFurnace::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX Cognitive Furnace'
  spec.description   = 'Smelt raw cognitive ore into refined understanding — alloy experiences, ' \
                       'observations, and intuitions at controlled temperatures to forge insight, wisdom, and theory'
  spec.homepage      = 'https://github.com/LegionIO/lex-cognitive-furnace'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/LegionIO/lex-cognitive-furnace'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-cognitive-furnace'
  spec.metadata['changelog_uri']     = 'https://github.com/LegionIO/lex-cognitive-furnace'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/LegionIO/lex-cognitive-furnace/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']
end
