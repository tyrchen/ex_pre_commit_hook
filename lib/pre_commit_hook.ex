defmodule PreCommitHook do
  @moduledoc """
  This module does nothing but copies the priv/.pre-commit to your .git/hooks/pre-commit.
  """
  alias PreCommitHook.Util

  @copy_files [
    {"pre-commit", ".git/hooks/pre-commit", true},
    {"credo.exs", ".credo.exs", false}
  ]

  @chmod_files [
    {".git/hooks/pre-commit", 0o755}
  ]

  top_dir = Util.get_project_top()

  @copy_files
  |> Enum.each(fn {src, dst, overwrite} ->
    Util.copy(Util.get_priv_file(src), Path.join(top_dir, dst), overwrite)
  end)

  @chmod_files
  |> Enum.each(fn {dst, mode} ->
    File.chmod(Path.join(top_dir, dst), mode)
  end)
end
