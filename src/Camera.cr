require "math"
require "./Utils"
require "./Vector"
require "./MathConst"
require "./Ray"

def degrees_to_radians(degrees : Float64) : Float64
  return degrees * MathConst::PI / 180.0
end

class Camera
  # パブリック
  property aspect_ratio : Float64
  property viewport_height : Float64
  property viewport_width : Float64
  # プライベート
  @lower_left_corner : Vec3
  @theta : Float64
  @h : Float64
  @w : Vec3
  @u : Vec3
  @v : Vec3
  @lens_radius : Float64

  def initialize(lookfrom : Point3, lookat : Point3, vup : Vec3, vfov : Float64, aspect_ratio : Float64, aperture : Float64, focus_dist : Float64)
    # (基本的には)定数の定義
    @aspect_ratio = aspect_ratio
    @theta = degrees_to_radians(vfov)
    @h = Math.tan(@theta/2)
    @viewport_height = 2.0 * @h
    @viewport_width = @aspect_ratio * @viewport_height

    @w = unit_vector(lookfrom - lookat)
    @u = unit_vector(cross(vup, @w))
    @v = cross(@w, @u)

    @origin = lookfrom
    @horizontal = focus_dist * @viewport_width * @u
    @vertical = focus_dist * @viewport_height * @v
    @lower_left_corner = @origin - @horizontal/2 - @vertical/2 - focus_dist * @w
    @lens_radius = aperture / 2
  end

  def get_ray(u : Float64, v : Float64) : Ray
    rd = @lens_radius * random_in_unit_disk()
    offset = (@u * rd.x) + (@v * rd.y)
    Ray.new(@origin + offset, @lower_left_corner + u*@horizontal + v*@vertical - @origin - offset)
  end
end
