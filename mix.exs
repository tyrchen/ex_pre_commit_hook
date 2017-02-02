defmodule PreCommitHook.Mixfile do
  use Mix.Project

  @version File.cwd!() |> Path.join("version") |> File.read! |> String.trim

  def project do
    [app: :pre_commit_hook,
     version: @version,
     elixir: "~> 1.4",
     description: description(),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      # test and dev
      {:credo, "~> 0.5", only: [:dev, :test]},
      {:ex_doc, "~> 0.14", only: :dev},
    ]
  end

  defp description do
    """
    PreCommitHook provides hook in ".git/hooks/pre-commit" which helps you to build elixir project with these checks:

    * code must be able to compile
    * code must pass basic linting (.credo.exs will be copied if it doesn't exist) and you can modify to fit for your need
    * code must pass test
    * code must pass docs generation.
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["tyr.chen@gmail.com"],
    ]
  end
end
