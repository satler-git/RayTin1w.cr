require "math"
require "./Vector"

class Ray
  # セッターとゲッター(パブリック化)
  property orig : Point3
  property dir : Vec3
  getter orig
  getter dir

  # 引数ありの初期化
  def initialize(origin : Point3, direction : Vec3)
    @orig = origin
    @dir = direction
  end

  def origin : Point3
    @orig
  end

  def direction : Vec3
    @dir
  end

  # 位置を計算
  def at(t : Float64) : Point3
    @orig + t*@dir
  end
end

def ray_color(r : Ray) : Color
  if hit_sphere(Point3.new(0, 0, -1), 0.5, r)
    return Color.new(1, 0, 0)
  end

  unit_direction : Vec3 = unit_vector(r.direction)
  t = 0.5*(unit_direction.y + 1.0)
  (1.0 - t)*Color.new(1.0, 1.0, 1.0) + t*Color.new(0.5, 0.7, 1.0)
end

def hit_sphere(center : Point3, radius : Float64, r : Ray) : Bool
  oc : Vec3 = r.origin - center
  a = dot(r.direction, r.direction)
  b = 2.0 * dot(oc, r.direction)
  c = dot(oc, oc) - radius*radius
  discriminant = b*b - 4*a*c
  discriminant > 0
end
