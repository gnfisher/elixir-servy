defmodule ProgrammingElixir.MyList do
  def mapsum([], _func), do: 0

  def mapsum([head | _tail], _func) when not is_integer(head) do
    raise "Not an integer"
  end

  def mapsum([head | tail], func) do
    func.(head) + mapsum(tail, func)
  end

  def max([]), do: raise "Cannot find max of empty list"
  def max([head | tail]) when not is_integer(head) do
    raise "Cannot find max of non integer"
  end
end
