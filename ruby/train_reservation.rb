class Reservation
  attr_reader :train_id
  attr_reader :seats

  def initialize(train_id, seats)
    @train_id = train_id
    @seats = seats
  end
end

class ReservationRequest
  attr_reader :train_id
  attr_reader :seat_count

  def initialize(train_id, seat_count)
    @train_id = train_id
    @seat_count = seat_count
  end
end

class TrainDataService
  def initialize(trains_json_map)
    @trains_json_map = trains_json_map
  end

  def get(train_id)
    @trains_json_map.fetch(train_id, "")
  end
end

class Seat
  attr_reader :carriage
  attr_reader :number

  def initialize(carriage, number)
    @carriage = carriage
    @number = number
  end
end

class TicketOffice
  def initialize(train_data_service)
    @train_data_service = train_data_service
  end

  def make_reservation(request)
    if bogus(request.train_id)
      Reservation.new(nil, [])
    else
      Reservation.new(request.train_id, [Seat.new("A", 1)])
    end
  end

  def bogus(train_id)
    @train_data_service.get(train_id).empty?
  end
end
