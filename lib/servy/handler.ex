defmodule Servy.Handler do
  @moduledoc "Handle HTTP requests."

  @pages_path Path.expand("../../pages", __DIR__)

  import Servy.Plugins, only: [rewrite_path: 1, log: 1]
  import Servy.Parser, only: [parse: 1]
  import Servy.FileHandler, only: [handle_file: 2]
  alias Servy.Conv

  @doc "Transforms the request into a response."
  def handle(req) do
    req
    |> parse
    |> log
    |> rewrite_path
    |> route
    |> format_response
  end

  def route(%Conv{method: "GET", path: "/pages/" <> file} = conv) do
    @pages_path
    |> Path.join("#{file}.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{} = conv) do
    route(conv, conv.method, conv.path)
  end

  def route(%Conv{} = conv, _, path) do
    %{conv | status: 404, resp_body: "No #{path} here"}
  end

  def format_response(%Conv{} = conv) do
    """
      HTTP/1.1 #{Conv.full_status conv}
      Content-Type: text/html
      Content-Length: #{String.length(conv.resp_body)}

      #{conv.resp_body}
    """
  end
end

request = """
  GET /wildthings HTTP/1.1
  Host: example.com
  User-Agent: ExampleBrowser/1.0
  Accept: */*

"""

request2 = """
  GET /bears HTTP/1.1
  Host: example.com
  User-Agent: ExampleBrowser/1.0
  Accept: */*

"""

request3 = """
  GET /bigfoot HTTP/1.1
  Host: example.com
  User-Agent: ExampleBrowser/1.0
  Accept: */*

"""

request4 = """
  GET /bears/1 HTTP/1.1
  Host: example.com
  User-Agent: ExampleBrowser/1.0
  Accept: */*

"""

request5 = """
  GET /bears?id=1234 HTTP/1.1
  Host: example.com
  User-Agent: ExampleBrowser/1.0
  Accept: */*

"""

request6 = """
  GET /pages/about HTTP/1.1
  Host: example.com
  User-Agent: ExampleBrowser/1.0
  Accept: */*

"""

response6 = Servy.Handler.handle(request6)
IO.puts(response6)
