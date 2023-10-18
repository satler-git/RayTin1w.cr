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
    orig
  end

  def direction : Vec3
    dir
  end

  # 位置を計算
  def at(t : Float64) : Point3
    @orig + t*@dir
  end
end

def ray_color(r : Ray) : Color
  unit_direction : Vec3 = unit_vector(r.direction)
  t = 0.5*(unit_direction.y + 1.0)
  (1.0 - t)*Color.new(1.0, 1.0, 1.0) + t*Color.new(0.5, 0.7, 1.0)
end
