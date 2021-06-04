defmodule Code_Op do
  @moduledoc """
  Documentation for Code_Op.
  """

  def additive_number(s) do
    str_list = String.codepoints(s)
    if "0" in str_list and List.first(str_list) != "0" and length(str_list) >=3 do
      range = 0..length(str_list) - 1
      Enum.all?(_additive_withZero(range, 1, s), fn(n) -> n == true end)
    else
      if List.first(str_list) == "0" || length(str_list) < 3 do
        false
      else
        dig_list = Enum.map(str_list, fn(n) -> String.to_integer(n) end)
        additive(dig_list, 2..length(dig_list), length(dig_list) - 1, dig_list)
      end
    end
  end
  defp _additive_withZero(low..high, _,_) when low == high, do: []
  defp _additive_withZero(low..high, n, num_string) do
    first_string = String.slice(num_string, 0..low)
    second_string = String.slice(num_string, low+1..low+n)
    first = String.to_integer(first_string)
    second = String.to_integer(second_string)
    sum = Integer.to_string(first + second)
    if String.contains?(String.slice(num_string, low + n + 1..high), sum) do
      if String.first(first_string) == "0" || String.first(second_string) == "0" do
        [false | _additive_withZero(1..1, 1, num_string)]
      else
        if low + n == high do
          [true| _additive_withZero(low + 1..high, 1, num_string)]
        else
          [true | _additive_withZero(low..high, n + 1, num_string)]
        end
      end
    else
      if low + n == high do
        _additive_withZero(low + 1..high, 1, num_string)
      else
        _additive_withZero(low..high, n + 1, num_string)
      end
    end

  end

  def additive(list, low..high, n, final) do
    results = _additive(list, low..high, n, final)
    if length(results) < high/3 do
      false
    else
      true
    end
  end
  defp _additive(_, _, 0, _) do
    []
  end
  defp _additive(list, low..high, n, final) do
    first_two = Enum.take(list, low)
    front_sum = Enum.sum(first_two)
    new_list = Enum.drop(list, low)
    if (((Enum.sum(Enum.take(new_list, ceil(low/2)))) == front_sum ||
           ((Enum.sum(Enum.take(new_list, ceil(low/2) + 1))) == front_sum) and low > 2) and
          ceil(low/2) <= length(new_list)) do
      final = Enum.drop(new_list, ceil(low/2))
      pre_next = Enum.drop(list, 1)
      next_round = if low == high or final == [] do
                      pre_next
                    else
                      list
                    end
      num = if (low != high and final != []) do
        n
      else
        n  - 1
      end
      new_low = if final == [] do
                2
            else
                low + 1
            end

      [true |_additive(next_round, new_low..high,num, final)]
    else
      next_round = if low == high or new_list == [] do
                    Enum.drop(list, 1)
                  else
                    list
                  end
      num = if (new_list != [] and new_list != []) do
        n
      else
        n  - 1
      end
      new_low = if new_list == [] do
                2
              else
                low + 1
              end
      _additive(next_round, new_low..high, num, new_list)
    end

  end
end
