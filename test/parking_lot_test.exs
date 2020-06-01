defmodule ParkingLotTest do
  use ExUnit.Case
  doctest ParkingLot

  describe "Parking" do
    setup [
      :count,
      :parking_data,
      :leave_slots,
      :color,
      :registration_no,
      :invalid_registration_no
    ]

    test "create slot", %{count: count} do
    end

    test "create parking", %{vehicles: vehicles} do
    end

    test "leave parking", %{slots: slots} do
    end

    test "color vehicle", %{color: color} do
    end

    test "registration vechile slot", %{registration_no: registration_no} do
    end

    test "invalid registration vechile slot", %{invalid_registration_no: registration_no} do
    end
  end

  defp parking_data(context) do
    vehicles_data = [
      %{registration_no: "KA-03-HU-2247", color: "BLACK"},
      %{registration_no: "KA-03-HU-2248", color: "BLACK"},
      %{registration_no: "KA-03-HU-2249", color: "WHITE"},
      %{registration_no: "KA-03-HU-2240", color: "BLUE"},
      %{registration_no: "KA-03-HU-2241", color: "BLUE"}
    ]

    {:ok, Map.put(context, :vehicles, vehicles_data)}
  end

  defp count(context) do
    {:ok, Map.put(context, :count, 5)}
  end

  defp leave_slots(context) do
    {:ok, Map.put(context, :slots, [2, 4, 5])}
  end

  defp color(context) do
    {:ok, Map.put(context, :color, "BLACK")}
  end

  defp registration_no(context) do
    {:ok, Map.put(context, :registration_no, "KA-03-HU-2241")}
  end

  defp invalid_registration_no(context) do
    {:ok, Map.put(context, :invalid_registration_no, "KA-03-HU")}
  end
end
