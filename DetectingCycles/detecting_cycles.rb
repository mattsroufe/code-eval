File.open(ARGV[0]).each_line do |line|
	input = line.split(" ").map { |s| s.to_i }
	hash = Hash.new(0)
	match = []
	n = input.length / 2
	for i in 2..n
		input.each_cons(i).each do |v|
  		hash[v] += 1
  	end
 	end
 	max = hash.values.max
  hash.each do |k, v|
  	if v >= 2 && v == max
  		match << k
  	end
  end
  puts match.last.join(" ") unless match.length == 0
end