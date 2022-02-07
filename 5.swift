// 2520 is the smalle nst number that can be divided by each of the numbers from 1 to 10 without any remainder.

// What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

func pow(_ x: Int, _ y: Int) -> Int {
    guard y > 0 else { return 1 }
    return (1...y).reduce(1) { acc, _ in acc * x }
}

func primeFactors(of n: Int) -> [Int] {
    guard n > 0 else { return [] }
    guard n > 3 else { return [n] }
    var factors: [Int] = []
    var div = n
    for i in 2...n/2 {
        while div % i == 0 { 
            factors += [Int(i)]
            div /= i
        }
        if div == 1 {
            break
        }
    }
    return factors.isEmpty ? [n] : factors
}

func leastCommonMultiple(of numbers: [Int]) -> Int {
    let allPrimeFactors = numbers.map { primeFactors(of: $0) }
    let allPowers: [[Int: Int]] = allPrimeFactors.lazy.map { factors in
        [Int: [Int]](grouping: factors, by: { $0 }).mapValues { $0.count }
    }
    let highestPowers = allPowers.reduce([Int: Int]()) { acc, elem in
        acc.merging(elem, uniquingKeysWith: max)
    }
    return highestPowers.map(pow).reduce(1, *)
}

let result = leastCommonMultiple(of: [Int](1...20))
print(result)
