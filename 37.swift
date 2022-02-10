// The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.

// Find the sum of the only eleven primes that are both truncatable from left to right and right to left.

// NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

// Sieve of Eratosthenes
// Odd numbers only
struct PrimeNumbers: Sequence, IteratorProtocol {
    private let bound: Int
    
    private var flags: [Bool]
    private var currentIndex: Int = -1
    private var count: Int { (bound-1)/2 }
    
    init(bound: Int) {
        self.bound = bound
        flags = [Bool](repeating: true, count: (bound-1)/2)
    }
    
    private func number(at index: Int) -> Int {
        2 * index + 3
    }
    
    private mutating func mark(from fromIndex: Int) {
        let number = number(at: fromIndex)
        let offset = number
        var idx = fromIndex + offset
        while idx <= count - 1 {
            flags[idx] = false
            idx += offset
        }
    }
    
    @discardableResult
    mutating func next() -> Int? {
        if currentIndex == -1 {
            currentIndex = 0
            return 2
        }
        if currentIndex >= count {
            return nil
        }
        guard let primeIndex = (currentIndex...count-1).first(where: { flags[$0] }) else {
            currentIndex = count
            return nil
        }
        let number = number(at: primeIndex)
        mark(from: primeIndex)
        currentIndex = primeIndex + 1
        return number
    }
}

func isPrime(_ n: Int) -> Bool {
    struct Map {
        static let isPrime: [Bool] = {
            let bound = 1000000
            var map = [Bool](repeating: false, count: bound)
            PrimeNumbers(bound: bound).forEach { map[$0] = true }
            return map
        }()
    }
    return Map.isPrime[n]
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
