defmodule ParkingLot.Core.Ticket do
  @moduledoc """
  This module provides the ticket of a vehicle
  """
  alias ParkingLot.Core.{Vehicle}
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

  # Private functions
  defp add_vechile(ticket, %{color: color, registration_no: reg_no} = _fields) do
    Map.put(ticket, :vehicle, Vehicle.new(%{color: color, registration_no: reg_no}))
  end

  defp add_slot(ticket, fields) do
    Map.put(ticket, :slot_id, fields[:slot_id])
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
