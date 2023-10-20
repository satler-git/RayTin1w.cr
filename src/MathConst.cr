require "math"

module MathConst
  infinity : Float64 = Float64::INFINITY
  pi : Float64 = 3.1415926535897932385

  def degrees_to_radians(degrees : Float64) : Float64
    degrees * pi / 180
  end
end
