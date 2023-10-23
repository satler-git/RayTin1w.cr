require "math"
require "./Vector"
require "./Ray"

abstract class Material
  abstract def scatter(r_in : Ray, rec : HitRecord) : Tuple(Bool, Ray, HitRecord, Color, Ray)
end

class Metal < Material
  property albedo
  def_clone

  def initialize(a : Color)
    @albedo = a
  end

  def scatter(r_in : Ray, rec : HitRecord) : Tuple(Bool, Ray, HitRecord, Color, Ray)
    reflected = reflect(unit_vector(r_in.direction), rec.normal)
    scattered = Ray.new(rec.p, reflected)
    attenuation = albedo
    result = (dot(scattered.direction, rec.normal) > 0)
    return {result, r_in, rec, attenuation, scattered}
  end
end
