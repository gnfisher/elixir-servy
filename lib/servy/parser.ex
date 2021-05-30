defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [top, body] = String.split(request, "\n\n")
    [request_line | headers] = String.split(top, "\n")

    [method, path, _] =
      request_line
      |> String.trim()
      |> String.split(" ")

    params = parse_params(body)

    %Conv{
      method: method,
      path: path,
      params: params
    }
  end

  defp parse_params(params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end
end
