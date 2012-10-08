require_relative 'celluloid-chain'

class A
  include Celluloid

  def test(x)
    puts "#{Time.now} #{x} start"
    sleep 1
    puts "#{Time.now} #{x} end"
  end
end

a = A.new

q = Celluloid::Chain.new(a)

3.times do |i|
  4.times do |n|
    x = "#{i}-#{n}"
    puts "#{Time.now} #{x} adding"
    q.add(:test, x)
  end
  sleep 2
end

# Would prefer to be notified when all items are completed
# q.wait

sleep
