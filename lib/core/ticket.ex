defmodule ParkingLot.Core.Ticket do
  @moduledoc """
  This module provides the ticket of a vehicle
  """
  defstruct id: nil,
            vehicle: %{},
            slot_id: nil,
            timestamp_entry: nil,
            timestamp_exit: nil,
            price: nil
end
