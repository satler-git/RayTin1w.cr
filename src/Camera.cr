require "math"
require "./Utils"
require "./Vector"
require "./Ray"

class Camera

  property aspect_ratio : Float64
  property viewport_height : Float64
  property viewport_width : Float64
  property focal_length : Float64

  def initialize
    # (基本的には)定数の定義
    @aspect_ratio = 16.0 / 9.0
    @viewport_height = 2.0
    @viewport_width = @aspect_ratio * @viewport_height
    @focal_length = 1.0
    @origin = Point3.new(0, 0, 0)
    @horizontal = Vec3.new(@viewport_width, 0.0, 0.0)
    @vertical = Vec3.new(0.0, @viewport_height, 0.0)
    @ower_left_corner = @origin - @horizontal/2 - @vertical/2 - Vec3.new(0, 0, @focal_length)
  end

  def get_ray(u : Float64, v : Float64) : Ray
    Ray.new(@origin, @lower_left_corner + u*@horizontal + v*@vertical - @origin)
  end
end