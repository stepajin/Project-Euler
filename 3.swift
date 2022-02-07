// The prime factors of 13195 are 5, 7, 13 and 29.

// What is the largest prime factor of the number 600851475143 ?

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

let result = primeFactors(of: 600851475143).last ?? 0
print(result)
