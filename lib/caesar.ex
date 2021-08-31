defmodule Caesar do
  def encode(n, str) do 
    str_points = String.codepoints(str)
    List.to_string(for c <- str_points, do: shift(n, c))
  end

  defmacrop is_lower?(c) do
    quote do
      unquote(c) in ~w(q w e r t y u i o p a s d f g h j k l z x c v b n m)
    end
  end

  defp shift(n, char_point) when is_lower?(char_point) do
    int_to_letter = fn(n) -> List.to_string([n + ?a]) end 

    letter_to_int = fn(char) ->
      <<ord_c>> = char
      ord_a = ?a
      ord_c - ord_a
    end

    alphabet_base = 26

    rem(letter_to_int.(char_point) + n, alphabet_base) 
      |> int_to_letter.()  
  end

  defp shift(_n, char_point), do: char_point
end
