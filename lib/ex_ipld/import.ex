defmodule ExIpld.Import do
  @moduledoc false

  require Logger

  defstruct root: nil, stats: %{}

  @spec new({:error, map}) :: {:error, map}
  def new({:error, data}) do
    {:error, data}
  end

  @spec new(list) :: ExIpld.import()
  def new(list) do
    [root | [stats]] = list

    %__MODULE__{
      root: ExIpld.ImportRoot.new(root["Root"]),
      stats: ExIpld.ImportStats.new(stats["Stats"])
    }
  end
end
