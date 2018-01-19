defmodule PreCommitHook.Mixfile do
  use Mix.Project

  @version File.cwd!() |> Path.join("version") |> File.read!() |> String.trim()

  def project do
    [
      app: :pre_commit_hook,
      version: @version,
      elixir: "~> 1.6",
      description: description(),
      package: package(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      # test and dev
      {:credo, "~> 0.8.10", only: [:dev, :test]},
      {:ex_doc, "~> 0.18.1", only: :dev}
    ]
  end

  defp description do
    """
    PreCommitHook provides hook in ".git/hooks/pre-commit" which helps you to build elixir project with these checks:

    * code must compile
    * code must pass basic linting (.credo.exs will be copied if it doesn't exist)
    * code must pass test
    * code must pass docs generation.
    """
  end

  defp package do
    [
      files: ["lib", "priv", "mix.exs", "README*", "LICENSE*", "version"],
      licenses: ["MIT"],
      maintainers: ["tyr.chen@gmail.com"],
      links: %{
        "GitHub" => "https://github.com/tyrchen/pre_commit_hook",
        "Docs" => "http://tyrchen.github.io/pre_commit_hook/"
      }
    ]
  end
end
