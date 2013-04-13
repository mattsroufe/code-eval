File.open(ARGV[0]).each_line do |line|
	input = line.split(" ").map { |s| s.to_i }
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