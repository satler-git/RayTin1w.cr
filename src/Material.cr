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

def reflectance(cosine : Float64, ref_idx : Float64)
  r0 = (1 - ref_idx) / (1 + ref_idx)
  r0 = r0*r0
  return r0 + (1 - r0)*((1 - cosine) ** 5)
end

class Dielectric < Material
  @ir : Float64

  def_clone

  def initialize(ri : Float64)
    @ir = ri
  end

  def scatter(r_in : Ray, rec : HitRecord) : Tuple(Bool, Ray, HitRecord, Color, Ray)
    attenuation = Color.new(1.0, 1.0, 1.0)
    refraction_ratio = rec.front_face ? (1.0 / @ir) : @ir

    unit_direction = unit_vector(r_in.direction)

    cos_theta = Math.min(dot(-unit_direction, rec.normal), 1.0)
    sin_theta = Math.sqrt(1.0 - cos_theta*cos_theta)

    cannot_refract = refraction_ratio * sin_theta > 1.0
    direction = Vec3.new

    if cannot_refract || reflectance(cos_theta, refraction_ratio) > random_double()
      direction = reflect(unit_direction, rec.normal)
    else
      direction = refract(unit_direction, rec.normal, refraction_ratio)
    end

    scattered = Ray.new(rec.p, direction)

    return {true, r_in, rec, attenuation, scattered}
  end
end
