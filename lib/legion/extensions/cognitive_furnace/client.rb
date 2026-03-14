# frozen_string_literal: true

require 'legion/extensions/cognitive_furnace/helpers/constants'
require 'legion/extensions/cognitive_furnace/helpers/ore'
require 'legion/extensions/cognitive_furnace/helpers/crucible'
require 'legion/extensions/cognitive_furnace/helpers/furnace_engine'
require 'legion/extensions/cognitive_furnace/runners/cognitive_furnace'

module Legion
  module Extensions
    module CognitiveFurnace
      class Client
        include Runners::CognitiveFurnace

        def initialize(**)
          @default_engine = Helpers::FurnaceEngine.new
        end

        def engine
          @default_engine
        end

        private

        attr_reader :default_engine
      end
    end
  end
end
