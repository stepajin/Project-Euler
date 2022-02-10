// Euler discovered the remarkable quadratic formula: n^2 + n + 41

// It turns out that the formula will produce 40 primes for the consecutive integer values 0 <= n <=39. However, when n = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41^2 + 41 + 41 is clearly divisible by 41.

// The incredible formula n^2 - 79n + 1601 was discovered, which produces 80 primes for the consecutive values 0 <= n <= 79. The product of the coefficients, −79 and 1601, is −126479.

// Considering quadratics of the form:
// n^2 + an + b, where |a| < 1000 and |b| <= 1000 
// where |n| is the modulus/absolute value of n
// e.g. |11| = 11 and |-4| = 4 

// Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.

var isPrime = [Bool](repeating: true, count: 200001)
for i in 2...200000 {
    guard isPrime[i] else { continue }
    for k in stride(from: i+i, through: 200000, by: i) {
        isPrime[k] = false
    }
}

func isPrime(_ n: Int) -> Bool {
    guard n >= 0, n <= 200000 else { return false }
    return isPrime[n]
}

func quadraticFormula(a: Int, b: Int) -> ((Int) -> Int) {
    { n in n*n + a*n + b }
}

var maxCount = 0
var result = 0
for a in (-999...999) {
    for b in (-1000...1000) {
        let formula = quadraticFormula(a: a, b: b)
        var primesCount = 0
        var n = 0
        while isPrime(formula(n)) { 
            primesCount += 1
            n += 1 
        }
        if primesCount > maxCount {
            maxCount = primesCount
            result = a * b
        }
    }
}
print(result)

