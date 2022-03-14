// Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.

// 37 36 35 34 33 32 31
// 38 17 16 15 14 13 30
// 39 18  5  4  3 12 29
// 40 19  6  1  2 11 28
// 41 20  7  8  9 10 27
// 42 21 22 23 24 25 26
// 43 44 45 46 47 48 49

// It is interesting to note that the odd squares lie along the bottom right diagonal, but what is more interesting is that 8 out of the 13 numbers lying along both diagonals are prime; that is, a ratio of 8/13 ≈ 62%.

// If one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed. If this process is continued, what is the side length of the square spiral for which the ratio of primes along both diagonals first falls below 10%?

// Sieve of Eratosthenes
// Odd numbers only
func isPrime(_ n: Int) -> Bool {
    struct Map {
        static let isPrime: [Bool] = {
            let bound = 700000000
            var flags = [Bool](repeating: true, count: (bound+1)/2)
            flags[0] = false
            for n in stride(from: 3, through: bound, by: 2) {
                guard flags[(n-1)/2] else { continue }
                for i in stride(from: 3 * n, through: bound, by: 2 * n) {
                    flags[(i-1)/2] = false
                }
            }
            return flags
        }()
    }
    return n % 2 == 0 ? n == 2 : Map.isPrime[(n-1)/2]
}

var primesCount = 0
var last = 1
for side in stride(from: 3, through: Int.max, by: 2) {
    let i = side / 2 + 1
    let step = 2 * (i - 1)
    let nums = (1...4).map { n in last + n * step }
    primesCount += nums.filter { isPrime($0) }.count
    let total = (i - 1) * 4 + 1
    let perc = Double(primesCount) / Double(total) * 100
    last = nums[3]
    if perc < 10 {
        print(side)
        break
    }
}