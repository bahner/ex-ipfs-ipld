defmodule ExIpfsIpld.Import do
  @moduledoc false

  require Logger

  import ExIpfs.Utils

  alias ExIpfs.Api
  alias ExIpfs.Link

  defstruct root: nil, stats: %{}

  @spec new({:error, map}) :: {:error, map}
  def new({:error, data}) do
    {:error, data}
  end

  @spec new(list) :: ExIpfsIpld.import()
  def new(list) do
    [root | [stats]] = list

    %__MODULE__{
      root: root(root["Root"]),
      stats: stats(stats["Stats"])
    }
  end

  @spec import(binary, list()) :: {:ok, ExIpfsIpld.import()} | Api.error_response()
  def import(data, opts \\ []) when is_binary(data) do
    Logger.debug("import: #{inspect(opts)}")
    opts = Keyword.put(opts, :stats, true)

    multipart_content(data)
    |> Api.post_multipart("/dag/import", query: opts)
    |> new()
    |> okify()
  end

  defp root(root) when is_map(root) do
    %{
      cid: Link.new(root["Cid"]),
      pin_error_msg: root["PinErrorMsg"]
    }
  end

  defp stats(stats) do
    Logger.debug("ImportStats.new(): #{inspect(stats)}")

    %{
      block_bytes_count: stats["BlockBytesCount"],
      block_count: stats["BlockCount"]
    }
  end
end
