defmodule PreCommitHook.Util do
  @moduledoc """
  Copy the file. Raise ``CompileError`` if copy failed.
  """

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
