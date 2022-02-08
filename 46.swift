// It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.

// 9 = 7 + 2×1^2
// 15 = 7 + 2×2^2
// 21 = 3 + 2×3^2
// 25 = 7 + 2×3^2
// 27 = 19 + 2×2^2
// 33 = 31 + 2×1^2

// It turns out that the conjecture was false.

// What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?

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

func primeNumbers(bound: Int) -> [Int] {
    Array(PrimeNumbers(bound: bound))
}

func isPrime(_ n: Int) -> Bool {
    struct Map {
        static let isPrime: [Bool] = {
            let bound = 100000
            var map = [Bool](repeating: false, count: bound)
            PrimeNumbers(bound: bound).forEach { map[$0] = true }
            return map			
        }()
    }
    return Map.isPrime[n]
}

let sqrts = [Int: Int](uniqueKeysWithValues: (1...1000).map { ($0 * $0, $0) })

outer: for i in stride(from: 9, through: 99999, by: 2) {
    if isPrime(i) { continue }
    for k in stride(from: 3, through: i-2, by: 2) {
        guard isPrime(k) else { continue }
        if sqrts[(i - k) / 2] != nil { continue outer }
    }
    print(i)
    break
}
