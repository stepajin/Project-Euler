// Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
// If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.

// For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

// Evaluate the sum of all the amicable numbers under 10000.

var sumsOfDivisors = [Int](repeating: 1, count: 10001)
(2...5000).forEach { n in
	(2...10000/n).forEach { sumsOfDivisors[$0 * n] += n }
}

let result = (2...10000).reduce(0) { acc, n in 
	let sum = sumsOfDivisors[n]
	guard sum > n, sum <= 10000 else { return acc }
	return sumsOfDivisors[sum] == n ? acc + n + sum : acc
}
print(result)