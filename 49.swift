//The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330, is unusual in two ways: (i) each of the three terms are prime, and, (ii) each of the 4-digit numbers are permutations of one another.

//There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting this property, but there is one other 4-digit increasing sequence.

//What 12-digit number do you form by concatenating the three terms in this sequence?

var isPrime = [Bool](repeating: true, count: 10000)
for i in (2...9999) {
    guard isPrime[i] else { continue }
    for k in stride(from: i+i, through: 9999, by: i) {
        isPrime[k] = false
    }
}

func combinations(_ numbers: [Int], _ count: Int) -> [[Int]] {
    guard count > 1 else { return numbers.map { [$0] } }
    return (0...numbers.count-count).flatMap { idx -> [[Int]] in
        let n = numbers[idx]
        let _numbers = Array(numbers.dropFirst(idx + 1))
        return combinations(_numbers, count-1).map { [n] + $0 }
    }
}

func isSequence(_ numbers: [Int]) -> Bool {
    Set(numbers.indices.dropFirst().map { numbers[$0] - numbers[$0-1] }).count == 1
}

func digits(_ n: Int) -> [Int] {
    String(n).map(String.init).compactMap(Int.init) 
}

func highestPermutation(_ n: Int) -> Int {
    Int(digits(n).sorted().reversed().map(String.init).joined())!
}

let primes = (1000...9999).filter { isPrime[$0] }
let permutations = [Int: [Int]](grouping: primes, by: highestPermutation(_:)).values
let triples = permutations.filter { $0.count >= 3 }.flatMap { combinations($0, 3) }
let sequences = triples.filter { isSequence($0) }

let result = sequences.map { $0.map(String.init).joined() }.first { $0 != "148748178147" }!
print(result)
