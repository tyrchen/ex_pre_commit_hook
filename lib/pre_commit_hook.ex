defmodule PreCommitHook do
  @moduledoc """
  This module does nothing but copies the priv/.pre-commit to your .git/hooks/pre-commit.
  """
  filename = "priv/pre-commit"
  file1 = :pre_commit_hook |> Application.app_dir |> Path.join(filename)
  file2 = File.cwd!() |> Path.join(filename)

  IO.puts "app_dir: #{file1}. #{inspect File.exists?(file1)}"
  IO.puts "cur_dir: #{file2}. #{inspect File.exists?(file2)}"
end
