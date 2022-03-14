// The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.

// There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

// How many circular primes are there below one million?

// Sieve of Eratosthenes
// Odd numbers only
func isPrime(_ n: Int) -> Bool {
    struct Map {
        static let isPrime: [Bool] = {
            let bound = 1000000
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
    return n % 2 == 0 ? n == 2 : Map.isPrime[(n-1)/2]
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
