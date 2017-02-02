defmodule PreCommitHook do
  @moduledoc """
  This module does nothing but copies the priv/.pre-commit to your .git/hooks/pre-commit.
  """
  alias PreCommitHook.Util
  top_dir = Util.get_project_top()

  :pre_commit_hook
    |> Application.get_env(:copy_files)
    |> Enum.each(fn {src, dst, overwrite} ->
      Util.copy(Util.get_priv_file(src), Path.join(top_dir, dst), overwrite)
    end)

  :pre_commit_hook
    |> Application.get_env(:chmod_files)
    |> Enum.each(fn {dst, mode} ->
      File.chmod(dst, mode)
    end)
end
