defmodule Mix.Tasks.TestAll do
  @moduledoc """
  Pre commit hook for .git/hooks/pre-commit. Should do alias like this:

    $ cd .git/hooks
    $ ln -s ../../.pre-commit pre-commit
  """
  use Mix.Task

  @spec run(any()) :: atom()
  def run(_) do
    with :ok <- compile(),
         :ok <- lint(),
         :ok <- test(),
         :ok <- doc(),
         :ok <- format() do
      System.halt(0)
      :ok
    else
      {:error, msg} ->
        IO.puts(msg)
        System.halt(1)
        :ok
    end
  end

  defp compile do
    IO.puts("Recompiling the project...")
    {result, code} = run_mix_cmd(["compile"])
    process(result, code, fn info -> Regex.match?(~r/warning:|compilation error/i, info) end)
  end

  defp lint do
    IO.puts("Linting the project...")
    {result, code} = run_mix_cmd(["credo"])
    process(result, code)
  end

  defp test do
    IO.puts("Testing the project...")
    {result, code} = run_mix_cmd(["test"])
    process(result, code)
  end

  defp doc do
    IO.puts("Generating docs...")
    {result, code} = run_mix_cmd(["docs"])
    process(result, code)
  end

  defp format do
    IO.puts("Fromatting source code...")
     {result, code} = run_mix_cmd(["format"])
     process(result, code)
  end

  defp run_mix_cmd(options) do
    System.cmd("mix", options, stderr_to_stdout: true)
  end

  defp process(result, code, check_eror \\ fn _ -> false end) do
    case code do
      0 ->
        found_error = check_eror.(result)

        case found_error do
          false -> :ok
          _ -> {:error, result}
        end

      _ ->
        {:error, result}
    end
  end
end
