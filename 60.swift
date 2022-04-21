// The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating them in any order the result will always be prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.

// Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.

extension Sequence {
    func firstValue<T>(_ transform: (Element) -> T?) -> T? {
        for element in self {
            guard let value = transform(element) else { continue }
            return value
        }
        return nil
    }
}

// Sieve of Eratosthenes
// Odd numbers only
func isPrime(_ n: Int) -> Bool {
    struct Map {
        static let isPrime: [Bool] = {
            let bound = 100000000
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

func isPrimeConcatenation(_ a: Int, _ b: Int) -> Bool {
    isPrime(Int("\(a)\(b)")!)
}

let primes = (2...9999).filter(isPrime(_:))

let map = [Int: [Int]](uniqueKeysWithValues: 
    primes.indices.dropLast().map { index in
        let a = primes[index]
        let values = primes.dropFirst(index+1).filter { b in
            isPrimeConcatenation(a, b) && isPrimeConcatenation(b, a)
        }
        return (a, values)
    }
)

func search(key: Int, path: [Int], remainingValues: [Int], depth: Int) -> [Int]? {
    let newPath = path + [key]
    guard depth > 1 else { return newPath }
    guard let values = map[key]?.filter(remainingValues.contains(_:)) else { return nil }
    return values.firstValue {
        search(key: $0, path: newPath, remainingValues: values, depth: depth-1)
    }
}

func search(key: Int, depth: Int) -> [Int]? {
    guard let values = map[key] else { return nil }
    return values.firstValue {
        search(key: $0, path: [key], remainingValues: values, depth: depth-1) 
    }
}

let path = map.keys.sorted().firstValue { search(key: $0, depth: 5) }!
let result = path.reduce(0, +)
print(result)
