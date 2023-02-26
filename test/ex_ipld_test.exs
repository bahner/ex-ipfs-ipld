defmodule ExIpldTest do
  @moduledoc false

  use ExUnit.Case, async: true
  @moduletag timeout: 180_000

  test "Should return ok RootCID" do
    {:ok, root} = ExIpld.put("{\"Key\":\"Value\"}")
    assert is_map(root)
    assert is_map(root)
    assert is_bitstring(root./)
    assert root./ === "bafyreia353cr2t26iiuw5g2triyfelqehsu5peq4pn2u6t6q6oktrplzly"

    {:ok, value} = ExIpld.get("bafyreia353cr2t26iiuw5g2triyfelqehsu5peq4pn2u6t6q6oktrplzly/Key")
    assert value === "Value"
    {:ok, value} = ExIpld.get("bafyreia353cr2t26iiuw5g2triyfelqehsu5peq4pn2u6t6q6oktrplzly")
    assert is_map(value)

    {:ok, value} = ExIpld.export("bafyreia353cr2t26iiuw5g2triyfelqehsu5peq4pn2u6t6q6oktrplzly")
    assert is_bitstring(value)
  end

  doctest ExIpld
end
