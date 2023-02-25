defmodule ExIpld.ImportRootTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias ExIpld.ImportRoot

  test "Import_root passes on error data" do
    data = %{
      "Message" => "this is an error",
      "Code" => 0
    }

    assert {:error, data} = ImportRoot.new({:error, data})
    assert data == %{"Code" => 0, "Message" => "this is an error"}
  end
end
