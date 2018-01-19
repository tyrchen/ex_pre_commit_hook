[
  inputs: [
    "config/**/*.{ex,exs}",
    "lib/**/*.{ex,exs}",
    "test/**/*.{ex,exs}",
    "mix.exs"
    ],
  locals_without_parens: [
    mount: 1,
    swagger: 1,
    helpers: 1,
    version: 1,
    plug: :*,
    plug_overridable: :*,
    requires: :*,
    optional: :*,
    group: :*,
    given: :*,
    mutually_exclusive: 1,
    exactly_one_of: 1,
    at_least_one_of: 1,
    all_or_none_of: 1,
    prefix: :*,
    rescue_from: :*,
    desc: :*,
    expose: :*,
    extend: :*,
    import_table: :*,
  ]
]
