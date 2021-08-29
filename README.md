# AwsLambda

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `aws_lambda` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:aws_lambda, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/aws_lambda](https://hexdocs.pm/aws_lambda).

Command:

```
docker run -it -v (pwd):/mnt/local bmalum/ellambda:beta /bin/bash -c 'cd /mnt/local; MIX_ENV=prod mix release --overwrite'; rm function.zip; zip -r function.zip .; aws lambda update-function-code --function-name aws_elixir_demo --zip-file fileb://function.zip
```