defmodule Servy.Plugins do
  require Logger

  alias Servy.Conv

  @doc "Logs requests"
  def log(conv) do
    Logger.info(conv)
    conv
  end

  def rewrite_path(%Conv{path: path} = conv) do
    regex = ~r{\/(?<thing>\w+)\?id=(?<id>\d+)}
    captures = Regex.named_captures(regex, path)

    rewrite_path_captures(conv, captures)
    |> log
  end

  def rewrite_path_captures(%Conv{} = conv, %{"thing" => thing, "id" => id}) do
    %{conv | path: "/#{thing}/#{id}"}
  end

  def rewrite_path_captures(%Conv{} = conv, nil), do: conv
end
