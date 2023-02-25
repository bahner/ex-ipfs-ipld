defmodule ExIpld.ImportTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias ExIpld.Import, as: Import

  test "fails on missing data" do
    catch_error(%Import{} = Import.new())
  end

  test "create new Import" do
    data = [
      %{
        "Root" => %{
          "Cid" => %{/: "QmYyQSo1c1Ym7orWxLYvCrM2EmxFTANf8wXmmE7DWjhx5N"},
          "PinErrorMsg" => "foo"
        }
      },
      %{"Stats" => %{"BlockBytesCount" => "213", "BlockCount" => "1"}}
    ]

    assert %Import{} = Import.new(data)
    imported = Import.new(data)

    assert imported.root.cid == %ExIpfs.Link{/: "QmYyQSo1c1Ym7orWxLYvCrM2EmxFTANf8wXmmE7DWjhx5N"}

    assert imported.root.pin_error_msg == "foo"
    assert imported.stats.block_bytes_count == "213"
    assert imported.stats.block_count == "1"
  end

  test "handles error data" do
    data = %{
      "Message" => "this is an error",
      "Code" => 0
    }

    assert {:error, data} = Import.new({:error, data})
    assert data == %{"Code" => 0, "Message" => "this is an error"}
  end
end
