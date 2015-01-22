class TrafficLight  
  include Enumerable

  def each
    yield [true, false, false]
    yield [true, true, false]
    yield [false, false, true]
    yield [false, true, false]
  end
end

class Bulb < Shoes::Shape
  attr_accessor :stack , :left, :top, :switched_on
  
  def initialize(stack, left, top, switched_on = false)    
    self.stack = stack
    self.left = left    
    self.top = top
    self.switched_on = switched_on
    draw left, top, bulb_colour
  end
  
  def draw(left, top, colour)    
    stack.fill(colour)
    stack.oval(left, top, 50)
  end

  def bulb_colour
    "#999999"
  end  
end


module TL
  Go = "#00FF30"
  Wait = "#FFFC00"
  Stop = "#FF0000"
end

  class StopBulb < Bulb
    def bulb_colour
      switched_on ? TL::Stop : "#999999"
    end
  end

  class WaitBulb < Bulb
    def bulb_colour
      switched_on ? TL::Wait : "#999999"
    end
  end

   class GoBulb < Bulb
    def bulb_colour
      switched_on ? TL::Go : "#999999"
    end
  end

Shoes.app :title => "My Amazing Traffic Light", :width => 150, :height => 250 do
  background "#000000".."#666666", :curve => 10, :margin => 25  
  stroke black    
  
  @traffic_light = TrafficLight.new
  @top = StopBulb.new self, 50, 40, true
  @middle = WaitBulb.new self, 50, 100, false
  @bottom = GoBulb.new self, 50, 160, false
  
  i = 1
  click do 
    animate(4) do
      if i < 4
        state = @traffic_light.entries[i]
          @top = StopBulb.new self, 50, 40, state[0]   
          @middle = WaitBulb.new self, 50, 100, state[1]
          @bottom = GoBulb.new self, 50, 160, state[2]
          i+=1
      else
        i=0
      end
    end
  end
end

