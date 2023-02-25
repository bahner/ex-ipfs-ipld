defmodule ExIpld.ImportRoot do
  @moduledoc false

  alias ExIpfs.Link
  require Logger
  defstruct cid: nil, pin_error_msg: nil

  @spec new({:error, any} | map) :: {:error, any} | ExIpld.import_root()
  def new({:error, data}) do
    {:error, data}
  end

  def new(root) when is_map(root) do
    %__MODULE__{
      cid: Link.new(root["Cid"]),
      pin_error_msg: root["PinErrorMsg"]
    }
  end
end
