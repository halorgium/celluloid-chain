require_relative 'celluloid-chain.rb'

class A
  include Celluloid

  def test(x)
    puts "test start #{x}"
    sleep 1
    puts "test end #{x} - #{Time.now}"
  end
end

a = A.new

q = Celluloid::Chain.new(a)

3.times do |i|
  4.times do |n|
    q.add(:test, "#{i}-#{n}")
  end
  sleep 3
end

