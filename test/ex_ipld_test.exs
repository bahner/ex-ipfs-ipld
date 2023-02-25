defmodule ExIpldTest do
  @moduledoc false

  use ExUnit.Case, async: true
  @moduletag timeout: 180_000

  alias ExIpld.Import
  alias ExIpld.ImportRoot
  alias ExIpld.ImportStats

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

    {:ok, value} = ExIpld.export("bafyreia353cr2t26iiuw5g2triyfelqehsu5peq4pn2u6t6q6oktrplzly")
    {:ok, imported} = ExIpld.import(value)
    assert is_map(imported)
    assert is_map(imported.root)
    assert is_map(imported.stats)
    assert %Import{} = imported
    assert %ImportRoot{} = imported.root
    assert %ImportStats{} = imported.stats
    assert imported.root.cid./ === "bafyreia353cr2t26iiuw5g2triyfelqehsu5peq4pn2u6t6q6oktrplzly"
    assert imported.root.pin_error_msg === ""
    assert is_integer(imported.stats.block_bytes_count)
    assert is_integer(imported.stats.block_count)
  end

  doctest ExIpld
end
