require "math"
require "./Vector"
require "./Ray"
require "./Material"

class HitRecord
  property p : Point3
  property t : Float64
  property normal : Vec3
  property front_face : Bool
  property mat_ptr : Material
  def_clone

  def initialize
    @p = Point3.new
    @t = 0.0
    @normal = Vec3.new
    @front_face = false
    @mat_ptr = Lambertian.new(Color.new)
  end

  def initialize(p : Point3, t : Float64, normal : Vec3, front_face : Bool, mat_ptr : Material)
    @p = p
    @t = t
    @normal = normal
    @front_face = front_face
    @mat_ptr = mat_ptr
  end

  def set_face_normal(r : Ray, outward_normal : Vec3)
    @front_face = dot(r.direction, outward_normal) < 0
    @normal = @front_face ? outward_normal : -outward_normal
  end
end

abstract class Hittable
  abstract def hit(r : Ray, t_min : Float64, t_max : Float64, rec : HitRecord) : Tuple(Bool, HitRecord)
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

  def hit(r : Ray, t_min : Float64, t_max : Float64, rec : HitRecord) : Tuple(Bool, HitRecord)
    temp_rec = HitRecord.new
    hit_anything = false
    closest_so_far = t_max

    @objects.each do |object|
      hit_action = object.hit(r, t_min, closest_so_far, temp_rec)
      if hit_action[0]
        temp_rec = hit_action[1]
        hit_anything = true
        closest_so_far = temp_rec.t
        rec = temp_rec.clone
      end
    end

    {hit_anything, rec}
  end
end
