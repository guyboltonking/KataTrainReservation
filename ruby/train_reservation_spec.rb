require_relative 'train_reservation.rb'

describe "A train reservation" do

  let (:trains_json_map) {
    {
      "local_1000" => <<-EOS,
{ "seats" : [ { "carriage" : "A", "seat_number" : "1" } ] }
EOS
    }
  }
  let (:train_data_service) { TrainDataService.new(trains_json_map) }
  let (:ticket_office) { TicketOffice.new(train_data_service) }


  describe "An empty reservation request" do
    let (:reservation_request) { 
      ReservationRequest.new("bogus", 0)
    }
    it "should return an empty reservation" do
      reservation = ticket_office.make_reservation(reservation_request)
      reservation.seats.should be_empty
    end
  end

  context "When no tickets have been booked" do
    context "when reserving a single seat" do

      context "with an unknown train ID" do
        let (:reservation_request) {
          ReservationRequest.new("bogus", 1) }
        let (:reservation) { 
          ticket_office.make_reservation(reservation_request) }

        describe "the reservation" do
          it "should have a nil train ID" do
            reservation.train_id.should be_nil
          end
        end
      end

      context "with a known train ID" do
        let (:known_train_id) { "local_1000" }
        let (:reservation_request) {
          ReservationRequest.new(known_train_id, 1) }
        let (:reservation) { 
          ticket_office.make_reservation(reservation_request) }

        describe "the reservation" do
          it "should have the same train ID as the request" do
            reservation.train_id.should == known_train_id
          end

          it "should have a single seat" do
            reservation.seats.size.should == 1
          end

          describe "the single seat" do
            let (:seat) { reservation.seats[0] }

            it "should have a number" do
              seat.number.should == 1
            end
        
            it "should have a carriage" do
              seat.carriage.should == "A"
            end
          end

        end

        
      end

    end
  end
end
