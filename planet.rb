require 'gosu'
require 'tiny_vector'

class Planet
  attr_accessor :pos, :p, :r, :t, :m, :g, :size, :colour, :other

  def initialize(initial_status)
    @pos, @p, @r, @t, @m, @g, @size, @colour = *initial_status
    @other = nil
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
    self.pos - other.pos
  end

  def mag
    dist.abs**3
  end

  def force_k
    g * other.m * m / mag
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
