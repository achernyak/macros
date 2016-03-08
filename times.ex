defmodule Times do
  defmacro times_n(n) do
    func_name = :"times_#{n}"
    quote do
      def unquote(func_name)(x), do: unquote(n) * x
    end
  end
end

defmodule Test do
  require Times
  Times.times_n(3)
  Times.times_n(4)
end
IO.puts Test.times_3(4) #=> 12
IO.puts Test.times_4(5) #=> 20
