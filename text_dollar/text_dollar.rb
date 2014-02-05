CURRENCY = { '90' =>    'Ninety',
             '80' =>    'Eighty',
             '70' =>   'Seventy',
             '60' =>     'Sixty',
             '50' =>     'Fifty',
             '40' =>     'Forty',
             '30' =>    'Thirty',
             '20' =>    'Twenty',
             '19' =>  'Nineteen',
             '18' =>  'Eighteen',
             '17' => 'Seventeen',
             '16' =>   'Sixteen',
             '15' =>   'Fifteen',
             '14' =>  'Fourteen',
             '13' =>  'Thirteen',
             '12' =>    'Twelve',
             '11' =>    'Eleven',
             '10' =>       'Ten',
             '1'  =>       'One', 
             '2'  =>       'Two',
             '3'  =>     'Three',
             '4'  =>      'Four',
             '5'  =>      'Five',
             '6'  =>       'Six',
             '7'  =>     'Seven',
             '8'  =>     'Eight',
             '9'  =>      'Nine' }

File.open(ARGV[0]).each_line do |str| 
  str.chomp!
  arr = str.reverse.scan(/.{1,3}/).reverse
  arr.each { |x| x.reverse! }
  output = ""
  if arr == ["1"]
    puts "OneDollar"
  else
    while arr.length > 0
      x = arr[0]
      while x.length > 0
        if x.length == 3
          output += "#{CURRENCY[x[0]]}Hundred" if CURRENCY[x[0]]
          x.slice!(0)
        elsif x.length == 2
          unless x[0] == "1"
            k = x[0] + "0"
            output += CURRENCY[k] if CURRENCY[k]
            x.slice!(0)
          else
            k = x[0..1]
            output += CURRENCY[k] if CURRENCY[k]
            x.slice!(0..1)
          end
        else
          output += CURRENCY[x[0]] if CURRENCY[x[0]]
          x.slice!(0)
        end
      end
      if arr.count == 3
        output += "Million"
      elsif arr.count == 2
        output += "Thousand"
      end
      arr.delete_at(0)
      arr.delete_at(0) if arr[0] == "000"
    end
    puts output + "Dollars"
  end
end
