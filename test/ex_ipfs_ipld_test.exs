defmodule ExIpfsIpldTest do
  @moduledoc false

  use ExUnit.Case, async: true
  @moduletag timeout: 180_000

  test "Should return ok RootCID" do
    {:ok, root} = ExIpfsIpld.put("{\"Key\":\"Value\"}")
    assert is_map(root)
    assert is_map(root)
    assert is_bitstring(root./)
    assert root./ === "bafyreia353cr2t26iiuw5g2triyfelqehsu5peq4pn2u6t6q6oktrplzly"

    {:ok, value} =
      ExIpfsIpld.get("bafyreia353cr2t26iiuw5g2triyfelqehsu5peq4pn2u6t6q6oktrplzly/Key")

    assert value === "Value"
    {:ok, value} = ExIpfsIpld.get("bafyreia353cr2t26iiuw5g2triyfelqehsu5peq4pn2u6t6q6oktrplzly")
    assert is_map(value)

    {:ok, value} =
      ExIpfsIpld.export("bafyreia353cr2t26iiuw5g2triyfelqehsu5peq4pn2u6t6q6oktrplzly")

    assert is_bitstring(value)
  end

  doctest ExIpfsIpld
end
