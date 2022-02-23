// There are exactly ten ways of selecting three from five, 12345:

// 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345

// In combinatorics, we use the notation, (5 / 3) = 10

// In general, (n / r) = n! / r!(n - r)!, where r <= n.

// It is not until n = 23, that a value exceeds one-million:

// (23 / 10) = 1144066

// How many, not necessarily distinct, values of (n / r) for 1 <= n <= 100, are greater than one-million?

func factorial(_ n: Int) -> Double {
    class Cache {
        static var map: [Int: Double] = [:]
    }
    if let f = Cache.map[n] { return f }
    guard n > 1 else { return 1.0 }
    let f = factorial(n-1) * Double(n)
    Cache.map[n] = f
    return f
}

func combinations(_ n: Int, _ r: Int) -> Double {
    factorial(n) / (factorial(r) * factorial(n - r))
}

let result = (23...100).lazy.map { n in 
    (1...n).lazy.filter { r in combinations(n, r) > 1000000.0 }.count
}.reduce(0, +)

print(result)

