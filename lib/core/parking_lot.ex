defmodule ParkingLot.Core.ParkingLot do
  @moduledoc """
  A module which takes care of the parking lot
  """

  alias ParkingLot.Core.{Slot}

  defstruct id: nil,
            slots: [],
            used_slots: []

  @spec new(integer()) :: %{:__struct__ => atom, optional(atom) => any}
  def new(slot_count) do
    parking_struct = struct!(__MODULE__, id: System.unique_integer([:monotonic, :positive]))

    parking_struct
    |> add_slots(slot_count)
  end

  # Private functions

  defp add_slots(%__MODULE__{} = parking_lot, slot_count) do
    slots =
      1..slot_count
      |> Stream.map(&Slot.new(id: &1))
      |> Enum.to_list()

    %{parking_lot | slots: slots}
  end
end
