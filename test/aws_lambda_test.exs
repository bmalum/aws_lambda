defmodule AwsLambdaTest do
  use ExUnit.Case
  doctest AwsLambda

  test "greets the world" do
    assert AwsLambda.hello() == :world
  end
end
