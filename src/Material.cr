require "math"
require "./Vector"
require "./Ray"

abstract class Material
  abstract def scatter(r_in : Ray, rec : HitRecord) : Tuple(Bool, Ray, HitRecord, Color, Ray)
end

class Metal < Material
  property albedo : Color
  property fuzz : Float64
  def_clone

  def initialize(a : Color, fuzz : Float64)
    @albedo = a
    @fuzz = fuzz < 1.0 ? fuzz : 1.0
  end

  def scatter(r_in : Ray, rec : HitRecord) : Tuple(Bool, Ray, HitRecord, Color, Ray)
    reflected = reflect(unit_vector(r_in.direction), rec.normal)
    scattered = Ray.new(rec.p, reflected + @fuzz*random_in_unit_sphere())
    attenuation = albedo
    result = (dot(scattered.direction, rec.normal) > 0)
    return {result, r_in, rec, attenuation, scattered}
  end
end

class Dielectric < Material
  @ref_idx : Float64

  def_clone

  def initialize(ri : Float64)
    @ref_idx = ri
  end

  def scatter(r_in : Ray, rec : HitRecord) : Tuple(Bool, Ray, HitRecord, Color, Ray)
    attenuation = Color.new(1.0, 1.0, 1.0)
    refraction_ratio = rec.front_face ? (1.0 / @ref_idx) : @ref_idx

    unit_direction = unit_vector(r_in.direction)
    refracted = refract(unit_direction, rec.normal, refraction_ratio)

    scattered = Ray.new(rec.p, refracted)

    return {true, r_in, rec, attenuation, scattered}
  end
end
