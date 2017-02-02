use Mix.Config

config :pre_commit_hook, copy_files: [
  {"pre-commit", ".git/hooks/pre-commit", true},
  {".credo.exs", ".credo.exs", false},
]

config :pre_commit_hook, chmod_files: [
  {".git/hooks/pre-commit", 0o755},
]
