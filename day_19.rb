input = File.open('input19.txt').read
input_text_splitted = (input.split(/-{3}.*[\n]/).map! { |x| x.split("\n")})[1..]

class Scanner
  def initialize(beacons_list)
    @beacons_list = []
    beacons_list.each do |beacon_coordinates|
      @beacons_list.push beacon_coordinates.split(",").map(&:to_i)
    end
  end
  def create_beacons
    beacon_map = []
    @beacons_list.each_with_index do |beacon, index|
      beacon_map.new(Beacon.new(beacon))
      @beacons_list.each_with_index do |beacon2, index2|
        if index != index2
          beacon_map[index].add_new_beacon(beacon2)
        end
      end
    end
  end
  def rotate
    
  end
end
class Beacon
  def initialize(beacon_coordinates)
    @neighbour_beacons =[]
    @x = beacon_coordinates[0]
    @y = beacon_coordinates[1]
    @z = beacon_coordinates[2]
    @coordinates = [@x, @y, @z]
  end
  def add_new_beacon(beacon_coordinates)
    @neighbour_beacons.push(beacon_coordinates.zip(@coordinates).map {|a,b| b - a})
  end
end

input_text_splitted.each do |scanner_cords|
  scanner = Scanner.new(scanner_cords)
  scanner.create_beacons
end
