// The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.

// Find the sum of the only eleven primes that are both truncatable from left to right and right to left.

// NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

// Sieve of Eratosthenes
// Odd numbers only
func isPrime(_ n: Int) -> Bool {
    struct Map {
        static let isPrime: [Bool] = {
            let bound = 1000000
            var flags = [Bool](repeating: true, count: 1000000)//(bound+1)/2)
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

func isTruncatableFromLeftPrime(_ n: Int) -> Bool {
    guard isPrime(n) else { return false }
    var residue = n / 10
    while isPrime(residue) { residue /= 10 }
    return residue == 0
}

func isTruncatableFromRightPrime(_ n: Int) -> Bool {
    guard isPrime(n) else { return false }
    var factor = 10
    while factor <= n && isPrime(n % factor) {
        factor *= 10
    }
    return factor > n
}

func isTruncatablePrime(_ n: Int) -> Bool {
    isTruncatableFromLeftPrime(n) && isTruncatableFromRightPrime(n)
}

var primes: [Int] = []
for i in stride(from: 11, through: Int.max, by: 2) {
    guard isTruncatablePrime(i) else { continue }
    primes.append(i);
    if primes.count == 11 { break }
}

let result = primes.reduce(0, +)
print(result)
