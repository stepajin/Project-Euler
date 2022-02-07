// The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

// Find the sum of all the primes below two million.

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

func sumOfPrimes(below bound: Int) -> Int {
    PrimeNumbers(bound: bound).reduce(0, +)
}

let result = sumOfPrimes(below: 2000000)
print(result)
