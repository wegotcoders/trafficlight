class TrafficLight
  include Enumerable

  def each
    yield [true, false, false]
    yield [true, true, false]
    yield [false, false, true]
    yield [false, true, false]
  end
end

module TL
  Go = "#00FF30"
  Wait = "#FFFC00"
  Stop = "#FF0000"
  Off = "#999999"
end

class Bulb < Shoes::Shape
  attr_accessor :stack
  attr_accessor :left
  attr_accessor :top
  attr_accessor :switched_on

  def initialize(stateck, left, top, switched_on = false)
    self.stack = stack
    self.left = left
    self.top = top
    self.switched_on = switched_on
    draw left, top, bulb_colour
  end

  # HINT: Shouldn't need to change this method
  def draw(left, top, colour)
    stack.fill(colour)
    stack.oval(left, top, 50)
  end

  def bulb_colour
    "#999999"
  end
end

class GoBulb < Bulb
  def bulb_colour
    if self.switched_on == true
      TL::Go
    else
      TL::Off
    end
  end
end

class WaitBulb < Bulb
  def bulb_colour
    if self.switched_on == true
      TL::Wait
    else
      TL::Off
    end
  end
end

class StopBulb < Bulb
  def bulb_colour
    if self.switched_on == true
      TL::Stop
    else
      TL::Off
    end
  end
end


Shoes.app :title => "My Amazing Traffic Light", :width => 150, :height => 250 do
  background "#000000".."#666666", :curve => 10, :margin => 25
  stroke black

  @traffic_light = TrafficLight.new
  @top = StopBulb.new self, 50, 40, false
  @middle = WaitBulb.new self, 50, 100, false
  @bottom = GoBulb.new self, 50, 160, true

  click do

  #current implementation takes 10 second to start loop.
  every (10) {
    @traffic_light.entries.each_index {|x|

      timer(2+2*x) {

        @top.switched_on = @traffic_light.entries[x][0]
        @middle.switched_on = @traffic_light.entries[x][1]
        @bottom.switched_on = @traffic_light.entries[x][2]

        @top.draw(@top.left, @top.top, @top.bulb_colour)
        @middle.draw(@middle.left, @middle.top, @middle.bulb_colour)
        @bottom.draw(@bottom.left, @bottom.top, @bottom.bulb_colour)
      }
    }
  }

  end
end
