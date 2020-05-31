defmodule ParkingLot.Application do
  use Application

  def start(_type, _args) do
    children = [
      {ParkingLot.Boundary.TicketManager, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mastery.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
