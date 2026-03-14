# lex-cognitive-furnace

Cognitive smelting engine for brain-modeled agentic AI in the LegionIO ecosystem.

## What It Does

Models the transformation of raw cognitive material into refined insights. Raw ores (experience, observation, hypothesis, data, intuition) are loaded into crucibles and heated incrementally. Once a crucible reaches the smelting threshold temperature (0.6), smelting converts all loaded ores into a single alloy (insight, wisdom, expertise, synthesis, or theory). Overheating a crucible past the destroy threshold (0.95) unconditionally destroys its contents before returning. The engine tracks all produced alloys in a history log. A separate ore store holds unloaded ores up to a configurable cap.

## Usage

```ruby
require 'legion/extensions/cognitive_furnace'

client = Legion::Extensions::CognitiveFurnace::Client.new

# Add raw ore to the store
result = client.add_ore(ore_type: :experience, domain: :engineering, content: 'debugging session insights', purity: 0.7)
ore_id = result[:ore_id]

# Create a crucible and load the ore
crucible = client.create_crucible(capacity: 5)
crucible_id = crucible[:crucible_id]
client.load_ore(ore_id: ore_id, crucible_id: crucible_id)

# Heat the crucible until ready to smelt
client.heat(crucible_id: crucible_id)
# => { success: true, before: 0.0, after: 0.1, label: :cold, overheated: false }

# Heat multiple times to reach smelt threshold (0.6)
6.times { client.heat(crucible_id: crucible_id) }

# Smelt loaded ores into an alloy
client.smelt(crucible_id: crucible_id, alloy_type: :insight)
# => { success: true, smelted: true, alloy: { ... } }

# Check furnace state
client.furnace_status
# => { success: true, report: { ore_count: 0, crucible_count: 1, alloy_history_count: 1, ... } }
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
