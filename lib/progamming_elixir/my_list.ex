defmodule ProgrammingElixir.MyList do
  def mapsum([], _func), do: 0

  def mapsum([head | tail], func) when is_integer(head) do
    func.(head) + mapsum(tail, func)
  end

  def mmax([]), do: raise "Cannot find max of empty list"

  def mmax([head | tail]) when is_integer(head) do
    mmax(tail, head)
  end

  defp mmax([], value), do: value

  defp mmax([head | tail], value) when is_integer(head) and head > value do
    mmax(tail, head)
  end

  defp mmax([head | tail], value) when is_integer(head) and head <= value do
    mmax(tail, value)
  end
end
