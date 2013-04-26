File.open(ARGV[0]).each_line do |line|
  input = line.split(" ").map { |s| s }
  m = input.delete(input.last)
  m = m.to_i
  if m <= input.length
    puts input[m - input.length]
  end
end