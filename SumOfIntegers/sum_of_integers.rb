File.open(ARGV[0]).each_line do |line|
	input = line.split(",").map { |s| s.to_i }
	hash = Hash.new(0)
	for i in 1..input.length
		input.each_cons(i).each do |v|
  		hash[v] = v.inject{|sum,x| sum + x }
  	end
 	end
 	puts hash.values.max
end