defmodule ParkingLot.Core.Slot do
  @moduledoc """
  This module provides the slot information
  """

  @enforce_keys ~w(id)a
  defstruct ~w(id ticket_id type)a

  def new(fields) do
    struct!(__MODULE__, fields)
  end
end
