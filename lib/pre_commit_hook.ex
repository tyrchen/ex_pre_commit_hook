defmodule PreCommitHook do
  @moduledoc """
  This module does nothing but copies the priv/.pre-commit to your .git/hooks/pre-commit.
  """
  alias PreCommitHook.Util

  @copy_files [
    {"pre-commit", "hooks/pre-commit", true},
    {"credo.exs", ".credo.exs", false}
  ]

  @chmod_files [
    {"hooks/pre-commit", 0o755}
  ]

  git_dir = Util.get_project_git()

  @copy_files
  |> Enum.each(fn {src, dst, overwrite} ->
    Util.copy(Util.get_priv_file(src), Path.join(git_dir, dst), overwrite)
  end)

  @chmod_files
  |> Enum.each(fn {dst, mode} ->
    File.chmod(Path.join(git_dir, dst), mode)
  end)
end
