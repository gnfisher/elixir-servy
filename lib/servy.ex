defmodule Servy do
  def hello(name, 1) do
    hello(name)
  end

  def hello(name, times) do
    IO.puts("Hello, #{name}")
    hello(name, times - 1)
  end

  def hello(name) do
    "Hello, #{name}!"
  end
end

IO.puts(Servy.hello("Tom", 3))
