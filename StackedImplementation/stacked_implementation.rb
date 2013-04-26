File.open(ARGV[0]).each_line do |line|
	a = line.split(" ").map { |s| s.to_i }
	b = []
	a.each do |n|
	  unless a.rindex(n) % 2 == 0
	    b << n.to_i
	  end
	end
	puts b.reverse.join(" ") unless b.length == 0
end