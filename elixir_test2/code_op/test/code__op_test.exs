defmodule Code_OpTest do
  use ExUnit.Case
  doctest Code_Op

  test "success test" do
    assert Code_Op.additive_number("12358")
    assert Code_Op.additive_number("121325")
    assert Code_Op.additive_number("123")
    assert Code_Op.additive_number("199100")
    assert Code_Op.additive_number("123456579")
  end

  test "fail test" do
    refute Code_Op.additive_number("1023")
    refute Code_Op.additive_number("102358")
    refute Code_Op.additive_number("123456")
  end
end
