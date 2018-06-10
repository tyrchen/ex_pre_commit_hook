defmodule PreCommitHook do
  @moduledoc """
  This module does nothing but copies the priv/.pre-commit to your .git/hooks/pre-commit.
  """
  alias PreCommitHook.Util
  alias UtilityBelt.ProjectTop

  top_dir = ProjectTop.get()

  copy_files = [
    {Util.get_priv_file("pre-commit"), ".pre-commit", false},
    {Path.join(top_dir, ".pre-commit"), ".git/hooks/pre-commit", true},
    {Util.get_priv_file("credo.exs"), ".credo.exs", false}
  ]

  chmod_files = [
    {".git/hooks/pre-commit", 0o755}
  ]

  copy_files
  |> Enum.each(fn {src, dst, overwrite} ->
    Util.copy(src, Path.join(top_dir, dst), overwrite)
  end)

  chmod_files
  |> Enum.each(fn {dst, mode} ->
    File.chmod(Path.join(top_dir, dst), mode)
  end)
end
