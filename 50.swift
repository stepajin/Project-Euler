// The prime 41, can be written as the sum of six consecutive primes:
// 41 = 2 + 3 + 5 + 7 + 11 + 13

// This is the longest sum of consecutive primes that adds to a prime below one-hundred.

// The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.

// Which prime, below one-million, can be written as the sum of the most consecutive primes?

let max = 1000000

var isPrime = [Bool](repeating: true, count: max+1)
for i in 2...max {
    guard isPrime[i] else { continue }
    for k in stride(from: i+i, through: max, by: i) {
        isPrime[k] = false
    }
}

let primes = (2...max).filter { isPrime[$0] }
var sums = primes
var result = 2
var longest = 1
var bound = primes.count

for length in 2...primes.count {
    guard length-1 < bound else { break }
    
    for idx in length-1...bound-1 {
        let sum = sums[idx] + primes[idx-length+1]
        sums[idx] = sum
        if sum >= max {
            bound = idx
            break
        }
        if length > longest, isPrime[sum] {
            longest = length
            result = sum
        }
    }
}

print(result)
