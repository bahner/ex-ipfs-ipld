# ExIpfsIpld

[![IPLD unit and integration tests](https://github.com/bahner/ex-ipld/actions/workflows/testsuite.yaml/badge.svg)](https://github.com/bahner/ex-ipld/actions/workflows/testsuite.yaml)
[![Coverage Status](https://coveralls.io/repos/github/bahner/ex-ipld/badge.svg?branch=main)](https://coveralls.io/github/bahner/ex-ipld?branch=main)

Elixir IPLD module. IPLD is linked data, so that you can build tree structures built up of discrete units (DAG). To learn more about IPLD visit https://ipld.io

You can for example add a pseudo structure like:

```json
{"Key": "Value", "List": [0, 1, 2, 3, 4, 5, 6]}
```
And add it to IPFS like this:

```elixir
iex(8)> json_string = "{\"Key\": \"Value\", \"List\": [0, 1, 2, 3, 4, 5, 6]}"
iex(9)> ExIpfsIpld.put(json_string)
{:ok,
 %ExIpfs.Link{/: "bafyreiflv5ldmhgxcdrixvdmh3sqoskooub76obvqwiabcekhvapk2kadi"}}
Iex(10)> ExIpfsIpld.get("bafyreiflv5ldmhgxcdrixvdmh3sqoskooub76obvqwiabcekhvapk2kadi/List/1")
{:ok, 1}
```

The data is structured, so that you can query the elements in the original data and data can be linked, like this:

```elixir
iex(19)> readme_ref = %{"Link": %{"/": "bafyreiflv5ldmhgxcdrixvdmh3sqoskooub76obvqwiabcekhvapk2kadi"}}
%{Link: %{/: "bafyreiflv5ldmhgxcdrixvdmh3sqoskooub76obvqwiabcekhvapk2kadi"}}
iex(20)> ExIpfsIpld.put(Jason.encode!(readme_ref))
{:ok,
 %ExIpfs.Link{/: "bafyreifwbyb5niiy2znptlz4cnltyo24pc2mlzjalfh7e2vlwy4wjvzdte"}}
iex(21)> ExIpfsIpld.get("bafyreifwbyb5niiy2znptlz4cnltyo24pc2mlzjalfh7e2vlwy4wjvzdte/Link/Key")
{:ok, "Value"}
iex(22)>
```

That's pretty cool :-)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_ipld` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_ipfs_ipld, "~> 1.0.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ex_ipld>.

