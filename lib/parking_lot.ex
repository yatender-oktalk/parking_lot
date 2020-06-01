defmodule ParkingLot do
  @moduledoc """
  Documentation for `ParkingLot`.
  """
  alias ParkingLot.Boundary.{ParkingManager, TicketManager}
  alias ParkingLot.Core.{ParkingLot}

  def park(registration_no, color) do
    case ParkingManager.park(registration_no, color) do
      {:ok, ticket} -> ticket.slot_id
      {:error, msg} -> msg
    end
  end

  def leave(slot_no) do
    _resp = ParkingManager.leave(slot_no)
    {:ok, "Slot number #{slot_no} is free"}
  end

  @spec status :: [map()]
  def status() do
    active_tickets = get_active_tickets()

    TicketManager.get_all_tickets()
    |> Enum.filter(&(&1.id in active_tickets))
    |> Enum.map(
      &%{
        slot_no: &1.slot_id,
        registration_no: &1.vehicle.registration_no,
        color: &1.vehicle.color
      }
    )
  end

  @spec registration_numbers_for_cars_with_colour(String.t()) :: [String.t()]
  def registration_numbers_for_cars_with_colour(color) do
    status() |> Enum.filter(&(&1.color == color)) |> Enum.map(& &1.registration_no)
  end

  @spec slot_numbers_for_cars_with_colour(String.t()) :: [number()]
  def slot_numbers_for_cars_with_colour(color) do
    status() |> Enum.filter(&(&1.color == color)) |> Enum.map(& &1.slot_no)
  end

  @spec slot_number_for_registration_number(String.t()) :: [number()]
  def slot_number_for_registration_number(registration_no) do
    status() |> Enum.filter(&(&1.registration_no == registration_no)) |> Enum.map(& &1.slot_no)
  end

  def create_parking_lot(slot_count) do
    TicketManager.clear_all_tickets()
    ParkingManager.create_slots(slot_count)
  end

  defp get_active_tickets() do
    %ParkingLot{used_slots: used_slots} = ParkingManager.state()
    used_slots |> Enum.map(& &1.ticket_id)
  end
end
