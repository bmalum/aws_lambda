defmodule AwsLambda.RuntimeLoop do
  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: :brutal_kill,
    }
  end

  def start_link(_args) do
    IO.inspect System.get_env()
    
    Task.start_link(fn -> loop() end)
  end

  def loop do
    get_next_invokation()
    loop()
  end

  def get_next_invokation do
    case :httpc.request(:get, {url(:next), []}, [{:timeout, :timer.seconds(60)}], []) do
      {:ok, {_proto, headers, payload}} ->
        header_map = for {key, val} <- headers, into: %{}, do: {List.to_string(key), val}
	
	data = Kernel.apply(String.to_atom("Elixir" <> System.get_env("_HANDLER")), :handler, [payload, header_map])
        send_response(header_map["lambda-runtime-aws-request-id"], data)

      _ ->
        report_initialization_error()
    end
  end

  def send_response(id, data) do
    :httpc.request(:post, {url(:response, id), [], 'application/json', data}, [], [])
  end

  def report_initialization_error do
    :httpc.request(
      :post,
      {url(:init_error), [], 'application/json', "Error while fetching Invocation"},
      [],
      []
    )
  end

  def report_invocation_error(id, error) do
    :httpc.request(:post, {url(:error, id), [], 'application/json', error}, [], [])
  end

  def url(event, id \\ nil) do
    lambda_runtime_api = System.get_env("AWS_LAMBDA_RUNTIME_API")
    base_url = "http://#{lambda_runtime_api}/2018-06-01"

    case event do
      :next -> base_url <> "/runtime/invocation/next"
      :response -> base_url <> "/runtime/invocation/#{id}/response"
      :error -> base_url <> "/runtime/invocation/#{id}/error"
      :init_error -> base_url <> "/runtime/init/error"
    end
    |> String.to_charlist()
  end
end
