# frozen_string_literal: true

class Supertramp
  class Config
    attr_accessor :colours, :uppercase, :shape
    alias colors= colours=

    def initialize
      @colours = %w[#B91C1C #B45309 #047857 #1D4ED8 #6D28D9]
      @uppercase = true
      @shape = Avatar::SQUARE
    end
  end
end
