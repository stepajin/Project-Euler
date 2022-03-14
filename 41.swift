// We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.

// What is the largest n-digit pandigital prime that exists?
import Foundation

// Sieve of Eratosthenes
// Odd numbers only
func isPrime(_ n: Int) -> Bool {
    struct Map {
        static let isPrime: [Bool] = {
            let bound = 10000000
            var flags = [Bool](repeating: true, count: (bound+1)/2)
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
    return n % 2 == 0 ? false : Map.isPrime[(n-1)/2]
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
