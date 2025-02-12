defmodule AshBug.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [AshBug.Repo]

    opts = [strategy: :one_for_one, name: AshBug.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
