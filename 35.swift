// The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.

// There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

// How many circular primes are there below one million?

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

func rotations(of n: Int) -> [Int] {
    var factor = 1
    while factor < n { factor *= 10  }
    if n == factor { return [n] }
    var rotation = n
    var result: [Int] = []
    repeat {
        let firstDigit = rotation / (factor / 10)
        result.append(rotation)
        rotation = (rotation * 10) - (firstDigit * factor) + firstDigit
    } while rotation != n
    return result
}

func hasOddDigitsOnly(_ n: Int) -> Bool {
    String(n).allSatisfy { $0 == "1" || $0 == "3" || $0 == "5" || $0 == "7" || $0 == "9" }
}

func isCircularPrime(_ n: Int) -> Bool {
    rotations(of: n).allSatisfy(isPrime(_:))
}

let circularPrimes = [2] + stride(from: 3, through: 999999, by: 2)
    .filter(hasOddDigitsOnly(_:))
    .filter(isCircularPrime(_:))

let result = circularPrimes.count
print(result)
