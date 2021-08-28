defmodule AwsLambdaTest.RuntimeLoop do
  use ExUnit.Case
  doctest AwsLambda.RuntimeLoop

  setup do 
    System.put_env("AWS_LAMBDA_RUNTIME_API", "localhost:8080")
  end
    
  test "next invocation url" do
    assert AwsLambda.RuntimeLoop.url(:next) == 'http://localhost:8080/2018-06-01/runtime/invocation/next'
  end

 
  test "reponse invocation url" do
    assert AwsLambda.RuntimeLoop.url(:response, "some_id") == 'http://localhost:8080/2018-06-01/runtime/invocation/some_id/response'
  end
end
