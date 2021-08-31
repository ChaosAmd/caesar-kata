defmodule CaesarTest do
  use ExUnit.Case
  doctest Caesar

  describe "encode/2" do
    test "one letter positive" do
      assert Caesar.encode(1, "a") == "b"
    end

    test "one letter negative" do
      assert Caesar.encode(-1, "a") == "`"
    end

    test "shift a string" do
      assert Caesar.encode(1, "abc") == "bcd"
    end

    test "shift with remaining" do 
      assert Caesar.encode(1, "zzz") == "aaa"
    end

    test "lower result" do
      assert Caesar.encode(1, "aaa") == "bbb"
    end
  end
end
