require 'gosu'
require './dwarf'
require './giant'

class SimWindow < Gosu::Window
  @@w = 1000
  @@h = 1000

  attr_reader :t, :particles
  private :t, :particles

  def initialize
    super @@w, @@h
    self.caption = 'Ruby :: Gosu :: Gravity :: Orbit'

    @dwarf = Dwarf.new
    @giant = Giant.new

    @particles = [@dwarf, @giant]

    @dwarf.giant = @giant
    @giant.dwarf = @dwarf
  end

  private

  def update
    particles.each(&:update)
  end

  def draw
    particles.each(&:draw)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

if __FILE__ == $0
  SimWindow.new.show
end
