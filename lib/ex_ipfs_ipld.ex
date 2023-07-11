defmodule ExIpfsIpld do
  @moduledoc """
  ExIpfsIpld handles linked data in IPFS.
  """
  require Logger

  import ExIpfs.Utils

  alias ExIpfs.Api

  alias ExIpfs.Link

  @typedoc """
  A struct that represents the import of a DAG.
  """
  @type import :: %ExIpfsIpld.Import{
          root: %{/: binary()},
          stats: %{
            block_bytes_count: integer | nil,
            block_count: integer | nil
          }
        }

  @doc """
  Streams the selected DAG as a .car stream on stdout.

  ## Options
  https://docs.ipfs.tech/reference/kubo/rpc/#api-v0-dag-export

  No options are relevant for this command.
  """
  # FIXME return a struct
  @spec export(binary()) :: {:ok, any} | Api.error_response()
  def export(cid) do
    Api.post_query("/dag/export?arg=" <> cid)
    |> okify()
  end

  @doc """
  Get a DAG node.

  ## Options
  https://docs.ipfs.tech/reference/kubo/rpc/#api-v0-dag-get
  """
  # FIXME return a struct
  @spec get(Path.t(), list()) :: {:ok, any} | Api.error_response()
  def get(path, opts \\ []) do
    with data <- Api.post_query("/dag/get?arg=" <> path, query: opts) do
      data
      |> Jason.decode!()
      |> okify()
    end
  end

  @doc """
  Import the contents of a DAG.

  The IPFS API does not currently support posting data directly to the endpoint. So
  we have to write the data to a temporary file and then post that file.

  ## Options
  https://docs.ipfs.tech/reference/kubo/rpc/#api-v0-dag-import
  """
  @spec import(binary, list()) :: {:ok, import()} | Api.error_response()
  defdelegate import(data, opts \\ []), to: ExIpfsIpld.Import

  @doc """
  Put an object to be encoded as a DAG object. There seems to be a bug in the
  IPFS API where the data is not being parsed correctly. Simple export can not be reimported at the moment.

  ## Options
  https://docs.ipfs.tech/reference/kubo/rpc/#api-v0-dag-put
  ```
  [
    store-codec: "<string>", # Default: "dag-cbor"
    input-codec: "<string>", # Default: "dag-json"
    pin: "<bool>", # Whether to pin object when adding. Default: false
    hash: "<string>", # Hash function to use. Default: "sha2-256"
    allow-big-block: <bool>, # Allow blocks larger than 1MB. Default: false
  ]
  ```
  """
  @spec put(binary, list()) :: {:ok, ExIpfs.link()} | Api.error_response()
  def put(data, opts \\ []) do
    multipart_content(data)
    |> Api.post_multipart("/dag/put", query: opts)
    |> Map.get("Cid", nil)
    |> Link.new()
    |> okify()
  end
end
