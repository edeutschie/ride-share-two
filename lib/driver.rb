require "csv"
require_relative 'trip'

module RideShareTwo
  class Driver

    attr_reader :driver_id, :name, :vin

    def initialize(driver_id, name, vin)
      @driver_id = driver_id
      @name = name
      @vin = vin
        raise ArgumentError.new("vin number is more or less than 17 characters") if vin.length != 17
    end

    def self.all_drivers
      all_drivers = []
      CSV.open("support/drivers.csv",{:headers => true}).each do |array|
        all_drivers << self.new(array[0].to_i, array[1], array[2])
      end
      return all_drivers
    end

    def self.find_driver(driver_id)
      result = self.all_drivers.select { |a| a.driver_id == driver_id }
      if result.empty?
        return "Not a driver"
      else
        return result.first
      end
    end

    def list_driver_trips
      RideShareTwo::Trip.driver_trips(@driver_id)
    end


    def average_rating
      total_rating = 0
      ratings = list_driver_trips.map {|trip| trip.rating}
      total_rating = ratings.sum
      average = total_rating.to_f / ratings.length.to_f
      return average
    end

  end

end

# these were lines for me for testing
# puts RideShareTwo::Driver.find_driver(13).list_driver_trips
# driver = RideShareTwo::Driver.find_driver(13)
# puts driver.list_driver_trips
# puts driver.average_rating
