// We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.

// What is the largest n-digit pandigital prime that exists?
import Foundation

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
            let bound = 10000000
            var map = [Bool](repeating: false, count: bound)
            PrimeNumbers(bound: bound).forEach { map[$0] = true }
            return map			
        }()
    }
    return Map.isPrime[n]
}

func isPandigital(_ i: Int) -> Bool {
    let s = String(i)
    return !s.contains("0") && s.count == Set(s).count
}


func pandigitalNumbers(from digits: [UInt8]) -> [Int] {
    if digits.count == 1 { return [Int(digits[0])] }
    return (0...digits.count-1).reversed().flatMap { index -> [Int] in
        let digit = digits[index]
        var other = digits
        other.remove(at: index)
        return pandigitalNumbers(from: other).compactMap { Int(String("\(digit)\($0)")) }
    }
}

for figures in (1...7).reversed() {
    let digits: [UInt8] = (1...figures).map(UInt8.init)
    if let result = pandigitalNumbers(from: digits).first(where: isPrime(_ :)) {
        print(result)
        break
    }
}
