require 'gosu'
require './vector'

class Giant
  attr_accessor :pos, :p, :r, :t, :m, :g, :size, :colour, :dwarf
  def initialize
    @pos = Vec.new([500,500,0])
    @p = Vec.new([0,0.2,0.0])*5.0
    @r = 0.075
    @t = 0.1
    @m = 5.0
    @g = 1.0

    @size = 10
    @colour = Gosu::Color::WHITE

    @dwarf = nil
    @orbit = []
  end

  def update
    update_momentum
    update_position
  end

  def draw
    Gosu::draw_rect(pos.x, pos.y, size, size, colour)
    @orbit.each_slice(2) do |head, tail|
      if tail != nil
        Gosu::draw_line(head.x, head.y, colour, tail.x, tail.y, colour)
      end
    end
  end

  private

  def dist
    (self.pos - @dwarf.pos)/20
  end

  def mag
    dist.abs**3
  end

  def force_k
    g * dwarf.m * m / mag
  end

  def force
    dist * force_k
  end

  def update_momentum
    @p -= force*t
  end

  def update_position
    @pos += p/m*t
    @orbit << pos
  end

  def random_colour
    Array.new(4) { prng.rand(0..255) }
  end

  def prng
    @prng ||= Random.new
  end
end
