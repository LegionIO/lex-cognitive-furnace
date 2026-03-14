# lex-cognitive-furnace

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Gem**: `lex-cognitive-furnace`

## Purpose

Models the smelting of raw cognitive material into refined insights. Raw ores (experience, observation, hypothesis, data, intuition) are loaded into crucibles and heated to a smelting threshold. At optimal temperature, smelting transforms loaded ores into alloys (insight, wisdom, expertise, synthesis, theory). Overheating destroys crucible contents. The process models the intense focused processing that converts raw input into durable cognitive output.

## Gem Info

| Field | Value |
|---|---|
| Gem name | `lex-cognitive-furnace` |
| Version | `0.1.0` |
| Namespace | `Legion::Extensions::CognitiveFurnace` |
| Ruby | `>= 3.4` |
| License | MIT |
| GitHub | https://github.com/LegionIO/lex-cognitive-furnace |

## File Structure

```
lib/legion/extensions/cognitive_furnace/
  cognitive_furnace.rb              # Top-level require
  version.rb                        # VERSION = '0.1.0'
  client.rb                         # Client class
  helpers/
    constants.rb                    # Ore/alloy types, temp labels, thresholds
    ore.rb                          # Ore value object
    crucible.rb                     # Crucible value object (manages ore loading, heating)
    furnace_engine.rb               # Engine: ores + crucibles + alloy history
  runners/
    cognitive_furnace.rb            # Runner module
```

## Key Constants

| Constant | Value | Meaning |
|---|---|---|
| `ORE_TYPES` | array | `[:experience, :observation, :hypothesis, :data, :intuition]` |
| `ALLOY_TYPES` | array | `[:insight, :wisdom, :expertise, :synthesis, :theory]` |
| `MAX_ORES` | 500 | Ore store cap |
| `MAX_CRUCIBLES` | 50 | Crucible cap |
| `HEAT_RATE` | 0.1 | Temperature increase per heat call |
| `COOL_RATE` | 0.05 | Temperature decrease per cool call |
| `SMELT_THRESHOLD` | 0.6 | Minimum temperature to attempt smelt |
| `DESTROY_THRESHOLD` | 0.95 | Temperature above this = overheated; destroys contents |
| `PURITY_LABELS` | hash | `refined` (0.8+) through `impure` |
| `TEMPERATURE_LABELS` | hash | `white_hot` (0.9+) through `cold` |

## Helpers

### `Ore`

Raw cognitive material awaiting processing.

- `initialize(ore_type:, domain:, content:, purity: 0.5, impurity: nil, ore_id: nil)`
- `purity`, `impurity`, `to_h`

### `Crucible`

Processing vessel that holds ores and tracks temperature.

- `initialize(capacity: 10, crucible_id: nil, temperature: 0.0)`
- `load_ore(ore_id)` — adds to capacity; returns error hash if full
- `heat!(rate)` — increases temperature
- `cool!(rate)` — decreases temperature
- `smelt!(ores, alloy_type: nil)` — smelts loaded ores at threshold; returns alloy or error
- `overheated?` — temperature >= `DESTROY_THRESHOLD`
- `optimal?` — temperature in smelt range
- `temperature_label`, `ore_ids`
- `to_h`

### `FurnaceEngine`

- `add_ore(ore_type:, domain:, content:, purity: 0.5, impurity: nil, ore_id: nil)` — returns `{ added:, ore_id:, ore: }` or capacity error
- `create_crucible(capacity: 10, temperature: 0.0)` — returns `{ created:, crucible_id:, crucible: }` or capacity error
- `load_ore(ore_id:, crucible_id:)` — validates both exist
- `heat_crucible(crucible_id:, rate: HEAT_RATE)` — returns before/after/label
- `cool_crucible(crucible_id:, rate: COOL_RATE)`
- `smelt(crucible_id:, alloy_type: nil)` — destroys on overheat; smelts at threshold; appends to alloy_history; removes smelted ores
- `cool_all!(rate: COOL_RATE)` — cools every crucible
- `purest_ores(limit: 10)`, `hottest_crucibles(limit: 10)`
- `furnace_report` — full stats

## Runners

**Module**: `Legion::Extensions::CognitiveFurnace::Runners::CognitiveFurnace`

Uses `extend self` pattern.

| Method | Key Args | Returns |
|---|---|---|
| `add_ore` | `ore_type:`, `domain:`, `content:`, `purity: 0.5` | `{ success:, ore_id:, ore: }` |
| `create_crucible` | `capacity: 10`, `temperature: 0.0` | `{ success:, crucible_id:, crucible: }` |
| `load_ore` | `ore_id:`, `crucible_id:` | `{ success:, loaded:, ... }` |
| `heat` | `crucible_id:`, `rate: HEAT_RATE` | `{ success:, before:, after:, label:, overheated: }` |
| `smelt` | `crucible_id:`, `alloy_type: nil` | `{ success:, smelted:, ... }` |
| `list_ores` | `limit: 50` | `{ success:, ores:, total: }` |
| `furnace_status` | — | `{ success:, report: }` |

Private: `furnace(engine)` — memoized `FurnaceEngine`. Logs via `log_debug` helper with `defined?(Legion::Logging)` guard.

## Integration Points

- **`lex-cognitive-genesis`**: Smelted alloys from the furnace feed concept genesis. Alloys are the refined inputs that enable seed germination into viable concepts.
- **`lex-memory`**: Smelted alloys represent insights that should be stored as memory traces after production.

## Development Notes

- Overheated crucibles destroy their contents unconditionally before returning. Callers should monitor temperature and avoid pushing past `DESTROY_THRESHOLD` (0.95).
- `smelt!` in the crucible requires temperature >= `SMELT_THRESHOLD` (0.6). Below threshold returns `{ smelted: false, reason: :temperature_too_low }`.
- After smelt, ore IDs are removed from both the ore map and the crucible's tracking list.
- In-memory only.

---

**Maintained By**: Matthew Iverson (@Esity)
