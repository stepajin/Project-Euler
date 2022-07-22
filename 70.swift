// Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of positive numbers less than or equal to n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6.
// The number 1 is considered to be relatively prime to every positive number, so φ(1)=1.

// Interestingly, φ(87109)=79180, and it can be seen that 87109 is a permutation of 79180.

// Find the value of n, 1 < n < 107, for which φ(n) is a permutation of n and the ratio n/φ(n) produces a minimum.

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

func isPermutation(_ a: Double, _ b: Double) -> Bool {
    String(a).sorted() == String(b).sorted()
}

let primes = PrimeNumbers(bound: 5000).filter { $0 > 1000 }.map(Double.init)
var minimum = Double.infinity
var result = Double.zero

// Result has to be a product of two primes (i, k)
for idx in primes.indices {
    let i = primes[idx]
    for k in primes.lazy.dropFirst(idx+1) {
        let n = i * k
        guard n <= 10000000 else { break }
        let phi = (i-1) * (k-1)
        guard isPermutation(n, phi) else { continue }
        let ratio = n/phi
        if ratio < minimum {
            minimum = ratio
            result = n
        }
    }
}
print(result)
