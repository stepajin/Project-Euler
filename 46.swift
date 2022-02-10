// It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.

// 9 = 7 + 2×1^2
// 15 = 7 + 2×2^2
// 21 = 3 + 2×3^2
// 25 = 7 + 2×3^2
// 27 = 19 + 2×2^2
// 33 = 31 + 2×1^2

// It turns out that the conjecture was false.

// What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?

var isPrime = [Bool](repeating: true, count: 100001)
for i in 2...100000 {
    guard isPrime[i] else { continue }
    for k in stride(from: i+i, through: 100000, by: i) {
        isPrime[k] = false
    }
}

let sqrts = [Int: Int](uniqueKeysWithValues: (1...1000).map { ($0 * $0, $0) })

outer: for i in stride(from: 9, through: 99999, by: 2) {
    if isPrime[i] { continue }
    for k in stride(from: 3, through: i-2, by: 2) {
        guard isPrime[k] else { continue }
        if sqrts[(i - k) / 2] != nil { continue outer }
    }
    print(i)
    break
}
