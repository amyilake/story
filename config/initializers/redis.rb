begin
  $redis = Redis.new(:host => 'localhost', :port => 6379)
rescue Exception => e
  puts "We requre redis"
end
