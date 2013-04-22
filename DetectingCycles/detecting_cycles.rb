File.open(ARGV[0]).each_line do |line|
	input = line.split(" ").map { |s| s.to_i }
	p input
	for x in 0...input.length
		for y in 0...input.length
	    unless x == y
	    	puts "#{input[x]}: #{input[y]}"
	    end
 	 	end
 	end
end




__END__

unless x == y
	      if input[x] == input[y] && input[x+1] == input[y+1] && input[x+2] == input[y+2] && input[x+3] == input[y+3]
	        puts "There is a four-number cycle: #{input[x]}, #{input[x+1]}, #{input[x+2]}, #{input[x+3]}."
	      elsif input[x] == input[y] && input[x+1] == input[y+1] && input[x+2] == input[y+2]
	        puts "There is a three-number cycle: #{input[x]}, #{input[x+1]}, #{input[x+2]}."
	      end
	    end


	hash = Hash.new(0)
	match = input.new(0)
	pattern = input.new(0)
	input.each do |v|
  	hash[v] += 1
  end
  hash.each do |k, v|
  	if v > 1
  		match << k
  	end
  end
  p match
  # if four numbers match

  for i in 0...input.length
  	if input[i] == match[0] && input[i+1] == match[1]
  		pattern << input[i]
  		pattern << input[i+1]
  	end
  end
  p pattern
end



		for y in 2..4
			test = input
			split = test.each_slice(y).to_a
			p split
		pattern = split.delete(split[0])
		# puts "Can #{pattern} be found in #{split}?"
		unless split.include?(pattern)
			test.delete_at(0)
		end
		p test
	end
end


		p match.detect{ |e| match.count(e) > 1 }


File.open(ARGV[0]).each_line do |line|
	input = line.split(" ").map { |s| s.to_i }
	
	hash = Hash.new(0)
	match = input.new(0)
	pattern = Hash.new(0)
	input.each do |v|
  	hash[v] += 1
  end
  hash.each do |k, v|
  	if v > 1
  		match << k
  	end
  end
  for x in 0...match.length
  	for y in 0...input.length
  		for i in 0...match.length
  			if match[x + i] == input[y + i]
  				pattern[y + i] += 1
  			end
  		end
  	end
  end
end

match.each do |x|
  	input.each do |y|
  		if x == y
  			puts y
  		end
  	end
  end


match = []
	input.each do |x|
		input.each do |y|
			if x == y
				match << y
			end
		end
		if match.length < 2
			match = []
		end
	end
	p match


for i in 0...input.length
		hash[i] = input[i]
	end
	p hash.values.uniq

p hash.sort_by {|key, value| value}

for x in 0...input.length
		for y in 0...input.length
			# unless hash[x] === hash[y]
			unless hash.has_key?(hash.key(y))
				puts "#{hash[x]}: #{hash[y]}"
			end
		end
	end


i = 0
	for i in i...input.size
		p input[i]
		{|a| h[a.to_sym] = a.upcase}
	end

	input.each do |x|
		input.each do |y|
			for i in 0...input.size
				unless x[i] == y[i]
					puts y[i]
				end
			end
			i += 1
		end
	end

	output = []
	a = input[0]
	b = input[1]
	n = input[2]
	for i in 1..n
		if i % (a * b) == 0
			output << "FB"
		elsif i % a == 0
			output << "F"
		elsif i % b == 0
			output << "B"
		else
			output << i
		end
	end
	puts output.join(" ")
end