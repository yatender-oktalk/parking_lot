defmodule ParkingLot.Core.Ticket do
  @moduledoc """
  This module provides the ticket of a vehicle
  """
  @type t :: %__MODULE__{}
  alias ParkingLot.Boundary.{TicketManager}
  @enforce_keys ~w(id vehicle slot_id timestamp_entry)a

  defstruct id: nil,
            vehicle: %{},
            slot_id: nil,
            timestamp_entry: nil,
            timestamp_exit: nil,
            price: nil

  @spec new(map()) :: %{:__struct__ => atom}
  def new(fields) do
    fields =
      Map.new()
      |> add_id(fields)
      |> add_vechile(fields)
      |> add_slot(fields)
      |> add_timestamp()

    struct!(
      __MODULE__,
      fields
    )
  end

  def add_ticket(%__MODULE__{} = ticket) do
    TicketManager.add_ticket(ticket)
    ticket.id
  end

  def get_id(ticket_id) do
    TicketManager.get_ticket(ticket_id)
  end

  # Private functions

  defp add_vechile(ticket, %{vehicle: vehicle} = _fields) do
    Map.put(ticket, :vehicle, vehicle)
  end

  defp add_slot(ticket, %{slot_id: slot_id} = _fields) do
    Map.put(ticket, :slot_id, slot_id)
  end

  defp add_timestamp(ticket) do
    Map.put(ticket, :timestamp_entry, DateTime.utc_now())
  end

  defp add_id(ticket, fields) do
    Map.put(ticket, :id, generate_id(fields))
  end

  defp generate_id(fields) do
    fields[:id] || System.unique_integer([:monotonic, :positive])
  end
end
