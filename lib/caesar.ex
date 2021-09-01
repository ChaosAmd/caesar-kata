defmodule Caesar do
  defp alphabet_base, do: 26

  defp freq_table, do: [8.1, 1.5, 2.8, 4.2, 12.7, 2.2, 2.0, 6.1, 7.0,
                      0.2, 0.9, 4.0, 2.4,  6.7, 7.5, 1.9, 0.1, 6.0,
                      6.3, 9.0, 2.8, 1.0,  2.4, 0.2, 2.0, 0.1]

  defp alphabet, do: for n <- ?a..?z, do: n

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

    rem(letter_to_int.(char_point) + n, alphabet_base()) 
      |> int_to_letter.()  
  end

  defp shift(_n, char_point), do: char_point

  def decode(encoded) do
    encoded_list = String.to_charlist(encoded)

    t = freqs(encoded_list)
    chitab = for n <- Enum.to_list(0..25), do: chi_square(rotate(n, t), freq_table())
    factor = hd positions(Enum.min(chitab), chitab)

    encode(factor * -1, encoded)
  end

  defp positions(c, char_list) do
    indexes = Enum.to_list(0..length(char_list))
    list_of_occurences = for {char, index} <- Enum.zip(char_list, indexes) do
      if char == c do
        index 
      end
    end

    list_of_occurences |> Enum.filter(fn (x) -> if x do x end end)
  end

  defp chi_square(os, es) do
    Enum.zip(os, es)
      |> Enum.map(fn({o, e}) -> :math.pow(o-e, 2)/2 end)
      |> Enum.sum()
  end

  defp rotate(n, xs) do
    Enum.drop(xs, n) ++ Enum.take(xs, n)
  end

  defp freqs(letters) do
    for x <- ?a..?z, do: percent(count(x, letters), lowers(letters))
  end

  defp percent(n, m), do: 100 * n / m

  defp count(c, str) do
    counted_binary = for x <- str, do: c == x
    counted_binary
      |> Enum.filter(fn (b) -> b == true end)
      |> length()
  end

  defp lowers(char_list) do
    char_list
      |> Enum.filter(fn (c) -> c in ?a..?z end)
      |> length()
  end
end
