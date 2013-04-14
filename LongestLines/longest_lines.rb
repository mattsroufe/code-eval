arr = []
File.open(ARGV[0]).each_line do |line|
	arr << line
end
n = arr.delete(arr[0]).to_i
arr = arr.sort {|x, y| y.length <=> x.length}
for i in 0...n
	puts arr[i]
end