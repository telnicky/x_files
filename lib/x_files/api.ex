defmodule XFiles.Api do
  defmodule InvalidAuthentication do
    defexception [:message]
  end

  def search(terms) do
    raise InvalidAuthentication, "Api token is invalid"
  end
end
