def make_change(amount, coins = [25, 10, 5, 1])
  optimal_change = []
  
  for i in 1..amount do
  	if coins.member?(i)
  		optimal_change[i-1] = [i]
  	else
	  	possible_coins = []
	  	coins.each do |coin|
	  		if ((i-1-coin) >= 0)
	  			possible_coins.push(Array.new(optimal_change[i-1-coin]).push(coin))
	  		end
	  	end
	  	possible_coins.sort_by! {|combo| combo.length}
	  	optimal_change[i-1] = possible_coins[0]
  	end
  end
  return optimal_change[amount-1].sort {|x,y| y<=>x}
end

puts make_change(39).inspect #=> [25, 10, 1, 1, 1, 1]
puts make_change(14, [10, 7, 1]).inspect #=> [7, 7]
