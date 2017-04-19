# SI

Formats + Parses [SI prefix numbers](https://en.wikipedia.org/wiki/Metric_prefix)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  SI:
    github: stereosteve/SI
```

## Usage

```crystal
require "SI"

SI.format(1.21e9, "W") # => "1.21 GW"
SI.parse("1.21 GW")    # => {1.21e9, "W"}
```

## See also

* [JS version](https://github.com/stereosteve/si-tools)
* [Go version](https://github.com/dustin/go-humanize)
* [Elixir version](https://github.com/danielberkompas/number)
