defmodule My do
  defmacro mydef(name) do
    quote bind_quoted: [name: name] do
      def unquote(name)(), do: unquote(name)
    end
  end
end

defmodule Scope do
  defmacro update_local(val) do
    local = "some value"
    result = quote do
      local = unquote(val)
      IO.puts "End of macro body, local = #{local}"
    end
    IO.puts "In macro definition, local = #{local}"
    result
  end
end

defmodule Operators do
  defmacro a + b do
    quote do
      to_string(unquote(a)) <> to_string(unquote(b))
    end
  end
end

defmodule Test do
  require My
  require Scope

  [:fred, :bert] |> Enum.each(&My.mydef(&1))

  local = 123
  Scope.update_local("cat")
  IO.puts "on return, local = #{local}"

  IO.puts(123 + 456)
  import Kernel, except: [+: 2]
  import Operators
  IO.puts(123 + 456)
end
