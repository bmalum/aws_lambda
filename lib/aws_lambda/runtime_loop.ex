defmodule AwsLambda.RuntimeLoop do
  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: :brutal_kill
    }
  end

  def start_link(_args) do
    Task.start_link(fn -> loop() end)
  end

  def loop do
    IO.puts("Loooping Louis")
    Process.sleep(1000)
    loop()
  end

  def get_next_invokation do 
    
  end

  def send_response do 
    
  end

  def report_initialization_error do
    
  end

  def report_invocation_error do
    
  end
end
