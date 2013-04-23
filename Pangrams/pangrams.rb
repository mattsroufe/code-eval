alphabet = "abcdefghijklmnopqrstuvwxyz".split("")
File.open(ARGV[0]).each_line do |line|
	array = line.gsub(/\s+/, "").downcase.split("").uniq.sort
	if array == alphabet
		puts "NULL"
	else
		puts [alphabet - array].join("")
	end
end