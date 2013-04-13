require 'prime'
File.open(ARGV[0]).each_line do |line|
	n = line.to_i
	output = []
	for i in 1...n
		if Prime.prime?(i)
			output << i
		end
	end
	puts output.join(",")
end