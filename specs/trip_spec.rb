require_relative 'spec_helper'


describe "Trip Initialize" do
    it "Takes an ID, Driver ID, Rider ID, date, and a rating" do

      trip_id = 1337
      driver_id = 54
      rider_id = 318
      date = "date"
      rating = 4
      trip = RideShareTwo::Trip.new(trip_id, driver_id, rider_id, date, rating)

      trip.must_respond_to :trip_id
      trip_id.must_equal trip_id

      trip.must_respond_to :driver_id
      trip.driver_id.must_equal driver_id

      trip.must_respond_to :rider_id
      trip.rider_id.must_equal rider_id

      trip.must_respond_to :date
      trip.date.must_equal date

      trip.must_respond_to :rating
      trip.rating.must_equal rating
    end

    it "Raises an ArgumentError if the rating is greater than 5" do
      proc {
        RideShareTwo::Trip.new(1337, 54, 318, "date", 6)
      }.must_raise ArgumentError
    end

    it "Raises an ArgumentError if the rating is 0" do
      proc {
        RideShareTwo::Trip.new(1337, 318, 54, "date", 0)
      }.must_raise ArgumentError
    end

    it "Raises an ArgumentError if the rating is less than 0" do
      proc {
        RideShareTwo::Trip.new(1337, 318, 54, "date", -3)
      }.must_raise ArgumentError
    end

end

describe "trip_driver_instance method" do
  let(:trip_object) {RideShareTwo::Trip.all_trips[4]}

  it "returns an instance of the driver class" do
    driver_object = trip_object.trip_driver_instance
    driver_object.must_be_instance_of RideShareTwo::Driver
  end
end


describe "trip_rider_instance method" do
  let(:trip_object) {RideShareTwo::Trip.all_trips[4]}

  it "returns an instance of the driver class" do
    rider_object = trip_object.trip_rider_instance
    rider_object.must_be_instance_of RideShareTwo::Rider
  end
end

describe "self.driver_trips" do
  let(:driver_trips_list) {RideShareTwo::Trip.driver_trips(13)}

  it "Returns an array (of all trips instances for a given driver ID)" do
    driver_trips_list
    driver_trips_list.must_be_kind_of Array, "Oops - the result is not an array"
  end

  it "Returns an array of all trips instances" do
    driver_trips_list
    driver_trips_list[0].must_be_instance_of RideShareTwo::Trip, "Oops - the item in the array is not a trip instance."
  end
end

describe "self.rider_trips" do
  let(:rider_trips_list) {RideShareTwo::Trip.rider_trips(137)}

  it "Returns an array (of all rider instances for a given rider ID)" do
    rider_trips_list
    rider_trips_list.must_be_kind_of Array, "Oops - the result is not an array"
  end

  it "Returns an array of all trips instances" do
    rider_trips_list
    rider_trips_list[0].must_be_instance_of RideShareTwo::Trip, "Oops - the item in the array is not a trip instance."
  end
end


describe "self.all_trips" do
  let(:trip_list) {RideShareTwo::Trip.all_trips}

  it "Returns an array of all trips" do
    trip_list
    trip_list.must_be_kind_of Array, "Oops - the class is not an array"
  end

  it "Everything in the array returned is a trip" do
    trip_list
    trip_list.each do |trip|
      trip.must_be_kind_of RideShareTwo::Trip, "This is not a trip."
    end
  end

  it "The number of trips is correct" do
    trip_list
    trip_list.length.must_equal 600, "Oops you are missing a trip!"
  end

  it "The ID of the first trip match what's in the CSV file" do
    trip_list
    trip_list[0].trip_id.must_equal 1, "Oops the first id is not in the array"
  end

  it "The date of the first trip match what's in the CSV file" do
    trip_list
    trip_list[0].date.must_equal "2016-04-05", "Oops the first date is not in the array"
  end

  it "The ID of the last trip match what's in the CSV file" do
    trip_list
    trip_list[599].trip_id.must_equal 600, "Oops the last id is not in the array"
  end

  it "The date of the last trip match what's in the CSV file" do
    trip_list
    trip_list[599].date.must_equal "2016-04-25", "Oops the last date is not in the array"
  end

end
