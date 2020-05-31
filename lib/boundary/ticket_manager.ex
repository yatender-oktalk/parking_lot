defmodule ParkingLot.Boundary.TicketManager do
  @moduledoc """
  This module takes care of the tickets session state
  """
  use GenServer
  alias ParkingLot.Core.{Ticket}

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(tickets) when is_list(tickets) do
    {:ok, tickets}
  end

  def init(_quizzes), do: {:error, "Tickets must be a list"}

  # Public functions
  def add_ticket(manager \\ __MODULE__, %Ticket{} = ticket) do
    GenServer.call(manager, {:add, ticket})
  end

  def get_ticket(manager \\ __MODULE__, ticket_id) do
    GenServer.call(manager, {:get, ticket_id})
  end

  def get_all_tickets(manager \\ __MODULE__) do
    GenServer.call(manager, :get_all)
  end

  def clear_all_tickets(manager \\ __MODULE__) do
    GenServer.cast(manager, :delete_all)
  end

  # call handlers
  def handle_call({:add, ticket}, _from, tickets) do
    {:reply, ticket, [ticket | tickets]}
  end

  def handle_call({:get, ticket_id}, _from, tickets) do
    {:reply, fetch_ticket(tickets, ticket_id), tickets}
  end

  def handle_call(:get_all, _from, tickets) do
    {:reply, tickets, tickets}
  end

  def handle_call(:delete_all, _from, _tickets) do
    {:noreply, []}
  end

  # Private functions
  defp fetch_ticket(tickets, ticket_id) do
    Enum.filter(tickets, fn ticket -> ticket.id == ticket_id end)
  end
end
