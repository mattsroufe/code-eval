# palindromic prime numbers are evenly divisible only by themselves 
# and 1 and have the same sequence of digits read forward or backward

require 'prime'
output = []
for i in 1...1000
	n = 1
	for n in 1..9
		if Prime.prime?(i) && /^#{n}\d?#{n}$/.match(i.to_s)
			output << i
		end
	end
end
puts output.last