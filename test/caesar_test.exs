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

  describe "decode/1" do
    test "one letter should returns K" do
      assert Caesar.decode("a") == "K"
    end

    test "inverses for regular word encode" do
      str = "test"
      assert Caesar.decode(Caesar.encode(2, str)) == str
    end

    test "does not decode for phrases without consistent letter frequency" do
      str = "The quick brown fox jumps over the lazy dog"
      refute Caesar.decode(Caesar.encode(2, str)) == str
    end
  end
end
