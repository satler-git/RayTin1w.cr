require "math"
require "./Vector"
require "./Ray"
require "./Hittable"

class Sphere < Hittable
  @center : Point3
  @radius : Float64

  def initialize(center : Point3, radius : Float64)
    @center = center
    @radius = radius
  end

  def hit(r : Ray, t_min : Float64, t_max : Float64, rec : HitRecord) : Bool
    oc = r.origin - @center
    a = r.direction.length_squared
    half_b = dot(oc, r.direction)
    c = oc.length_squared - @radius * @radius
    discriminant = half_b * half_b - a * c

    if discriminant > 0
      root = Math.sqrt(discriminant)
      temp = (-half_b - root) / a
      if temp < t_max && temp > t_min
        rec.t = temp
        rec.p = r.at(temp)
        outward_normal = (rec.p - @center) / @radius
        rec.set_face_normal(r, outward_normal)
        return true
      end
      temp = (-half_b + root) / a
      if temp < t_max && temp > t_min
        rec.t = temp
        rec.p = r.at(temp)
        outward_normal = (rec.p - @center) / @radius
        rec.set_face_normal(r, outward_normal)
        return true
      end
    end

    return false
  end
end
