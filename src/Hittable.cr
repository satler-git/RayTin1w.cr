require "math"
require "./Vector"
require "./Ray"

struct HitRecord
  property p : Point3
  property t : Float64
  property normal : Vec3
  property front_face : Bool
  def_clone
  
  def initialize(p : Point3, t : Float64, normal : Vec3, front_face : Bool)
    @p = p
    @t = t
    @normal = normal
    @front_face = front_face
  end

  def set_face_normal(r : Ray, outward_normal : Vec3)
    front_face = dot(r.direction, outward_normal) < 0
    @normal = front_face ? outward_normal : -outward_normal
  end

  
end


abstract class Hittable
  abstract def hit(r : Ray, t_min : Float64, t_max : Float64, rec : HitRecord) : Bool
end

class HittableList < Hittable
  @objects : Array(Hittable)
  def initialize
    @objects = [] of Hittable
  end

  def initialize(object : Hittable)
    @objects = [] of Hittable
    add(object)
  end

  def clear
    @objects.clear
  end

  def add(object : Hittable)
    @objects << object
  end

  def hit(r : Ray, t_min : Float64, t_max : Float64, rec : HitRecord) : Bool
    temp_rec = HitRecord.new(Point3.new, 0.0, Vec3.new, true)  
    hit_anything = false
    closest_so_far = t_max

    @objects.each do |object|
      if object.hit(r, t_min, closest_so_far, temp_rec)
        hit_anything = true
        closest_so_far = temp_rec.t
        rec = temp_rec.clone
      end
    end

    hit_anything
  end
end
