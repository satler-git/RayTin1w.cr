require "math"
require "./Vector"
require "./MathConst"

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

def ray_color(r : Ray, world : Hittable) : Color
  rec = HitRecord.new
  hit_action = world.hit(r, 0, Float64::INFINITY, rec)
  rec = hit_action[1]
  if hit_action[0]
    return 0.5 * (rec.normal + Color.new(1, 1, 1))
  end

  unit_direction : Vec3 = unit_vector(r.direction)
  t = 0.5 * (unit_direction.y + 1.0)
  return (1.0 - t) * Color.new(1.0, 1.0, 1.0) + t * Color.new(0.5, 0.7, 1.0)
end

def hit_sphere(center : Point3, radius : Float64, r : Ray) : Float64
  oc : Vec3 = r.origin - center
  a = dot(r.direction, r.direction)
  b = 2.0 * dot(oc, r.direction)
  c = dot(oc, oc) - radius * radius
  discriminant = b * b - 4 * a * c

  if discriminant < 0
    return -1.0
  else
    return (-b - Math.sqrt(discriminant)) / (2.0 * a)
  end
end
