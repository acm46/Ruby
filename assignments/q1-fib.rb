def fib(n, n1 = 1, n2 = 1)
	return n1 if n == 1
	return n2 if n == 2
	for i in 3..n do
		sum = n1+n2
		n1 = n2
		n2 = sum
	end
	return sum
end