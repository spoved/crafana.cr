# Crafana [![Build Status](https://travis-ci.org/spoved/crafana.cr.svg?branch=master)](https://travis-ci.org/spoved/crafana.cr)

This library is intended to help autogenerate Grafana dashboards

## Installation

Add the dependency to your project's `shard.yml`:

```
dependencies:
  crafana:
    github: spoved/crafana.cr
```

## Usage

### Builder

The `Crafana::Builder` can be used to generate dashboards and sub panels.

```
builder = Crafana::Builder.new
builder.add_dashboard("My new dash") do |dash|
  # Add sub panels to the dashboard here

  dash.add_row("row 1") do |row|
    # Configure row here
  end

  dash.add_graph("graph 1") do |graph|
    # Configure graph here
  end
end
```

The dashboard json can be exported via the `to_json` method.

```
builder.dashboards.first.to_json
```

## Contributing

1. Fork it (<https://github.com/spoved/crafana/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Holden Omans](https://github.com/kalinon) - creator and maintainer
- [Christian Nicolai](https://github.com/cmur2) - Superuser!
