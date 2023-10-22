require "math"
require "random"

def random_double : Float64
  # ランダムな数を返す
  random = Random.new
  rand = random.rand(Float64)
  random.destroy
  rand
end

def random_double(min : Float64, max : Float64)
  min + (max-min)*random_double()
end
