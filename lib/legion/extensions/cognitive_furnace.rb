# frozen_string_literal: true

require 'securerandom'
require 'legion/extensions/cognitive_furnace/version'
require 'legion/extensions/cognitive_furnace/helpers/constants'
require 'legion/extensions/cognitive_furnace/helpers/ore'
require 'legion/extensions/cognitive_furnace/helpers/crucible'
require 'legion/extensions/cognitive_furnace/helpers/furnace_engine'
require 'legion/extensions/cognitive_furnace/runners/cognitive_furnace'
require 'legion/extensions/cognitive_furnace/client'

module Legion
  module Extensions
    module CognitiveFurnace
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
