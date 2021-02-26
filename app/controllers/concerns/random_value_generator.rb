module RandomValueGenerator
  extend ActiveSupport::Concern

  require "securerandom"

  def random_number_generator(n)
    ''.tap { |s| n.times { s << rand(0..9).to_s } }
  end
end
