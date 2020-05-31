defmodule ParkingLot.Boundary.ParkignManager do
  @moduledoc """
    The `ParkingLot.Boundary.ParkignManager` server implementation
    A module which handles everything related to parking and manages the parking state
  """

  use GenServer
  alias ParkingLot.Core.{ParkingLot}

  ##############################################################################

  @doc "Starts the `ParkingLot.Boundary.ParkignManager` server up"
  def start_link(slot_count \\ 6) do
    GenServer.start_link(__MODULE__, slot_count, name: __MODULE__)
  end

  @doc """
  Initialize the state of the parking lot
  """
  @impl true
  def init(slot_count) do
    parking_lot = ParkingLot.new(slot_count)
    {:ok, parking_lot}
  end

  ###############################################################################
  # Public APIs                                                                 #
  ###############################################################################
  def park(manager \\ __MODULE__, registration_no, color) do
    GenServer.call(manager, {:park, registration_no, color})
  end

  ##############################################################################
  #### Call Handlers                                                      ######
  ##############################################################################

  @impl true
  def handle_call({:park, registration_no, color}, _from, state) do
    {_status, ticket, state} = ParkingLot.park(state, registration_no, color)
    {:reply, ticket, state}
  end

  @impl true
  def handle_call({:leave, slot_id}, _from, state) do
    {_status, msg, state} = ParkingLot.leave(state, slot_id)
    {:reply, msg, state}
  end
end
