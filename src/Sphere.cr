require "math"
require "./Vector"
require "./Ray"
require "./Hittable"
require "./Material"

class Sphere < Hittable
  @center : Point3
  @radius : Float64
  @mat_ptr : Material

  def initialize(center : Point3, radius : Float64, m : Material)
    @center = center
    @radius = radius
    @mat_ptr = m
  end

  def hit(r : Ray, t_min : Float64, t_max : Float64, rec : HitRecord) : Tuple(Bool, HitRecord)
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
        rec.mat_ptr = @mat_ptr
        return {true, rec}
      end
      temp = (-half_b + root) / a
      if temp < t_max && temp > t_min
        rec.t = temp
        rec.p = r.at(temp)
        outward_normal = (rec.p - @center) / @radius
        rec.set_face_normal(r, outward_normal)
        rec.mat_ptr = @mat_ptr
        return {true, rec}
      end
    end

    return {false, rec}
  end
end

class Lambertian < Material
  property albedo : Color
  def_clone

  def initialize(albedo : Color)
    @albedo = albedo
  end

  def scatter(r_in : Ray, rec : HitRecord) : Tuple(Bool, Ray, HitRecord, Color, Ray)
    # 本来参照が渡されることを前提としたコードかも
    scatter_direction = rec.normal + random_unit_vector()
    scattered = Ray.new(rec.p, scatter_direction)
    attenuation = @albedo
    return {true, r_in, rec, attenuation, scattered}
  end
end
