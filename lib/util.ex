defmodule PreCommitHook.Util do
  @moduledoc """
  Copy the file. Raise ``CompileError`` if copy failed.
  """
  alias Mix.Project

  @max_recursive_level 3

  @doc false
  @spec copy(String.t(), String.t(), boolean()) :: atom()
  def copy(src_file, dst_file, overwrite \\ true) do
    case overwrite do
      true ->
        do_copy(src_file, dst_file)

      false ->
        if not File.exists?(dst_file) do
          do_copy(src_file, dst_file)
        end
    end

    :ok
  end

  @doc false
  @spec get_priv_file(String.t()) :: String.t()
  def get_priv_file(name) do
    :pre_commit_hook |> Application.app_dir() |> Path.join("priv/#{name}")
  end

  @doc false
  @spec get_project_top() :: String.t()
  def get_project_top do
    path = Project.deps_path() |> Path.join("..")
    get_path(path, @max_recursive_level)
  end

  @doc false
  @spec get_project_git() :: String.t()
  def get_project_git do
    Path.join(get_project_top(), '.git')
  end

  defp get_path(path, 0), do: raise("Cannot find top path in #{path}")

  defp get_path(path, level) do
    case File.exists?(Path.join(path, '.git')) do
      true ->
        path

      _ ->
        get_path(Path.join(path, '..'), level - 1)
    end
  end

  defp do_copy(src_file, dst_file) do
    File.copy!(src_file, dst_file)
  rescue
    _e in File.CopyError ->
      IO.puts(
        "Cannot copy from #{src_file} to #{dst_file}. Make sure your project is under a git repo."
      )

      reraise CompileError, System.stacktrace()

    _ ->
      reraise CompileError, System.stacktrace()
  end
end
