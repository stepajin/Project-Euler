// By replacing the 1st digit of the 2-digit number *3, it turns out that six of the nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.

// By replacing the 3rd and 4th digits of 56**3 with the same digit, this 5-digit number is the first example having seven primes among the ten generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993. Consequently 56003, being the first member of this family, is the smallest prime with this property.

// Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.

var isPrime = [Bool](repeating: true, count: 1000001)
for i in (2...1000000) {
    guard isPrime[i] else { continue }
    for k in stride(from: i+i, through: 1000000, by: i) {
        isPrime[k] = false
    }
}

func isPrime(_ n: Int) -> Bool {
    isPrime[n]
}

func digits(_ n: Int) -> [Int] {
    String(n).map(String.init).compactMap(Int.init)
}

func number(_ digits: [Int]) -> Int {
    Int(digits.map(String.init).joined())!
}

func combinations(_ numbers: [Int], _ count: Int) -> [[Int]] {
    guard count > 1 else { return numbers.map { [$0] } }
    return (0...numbers.count-count).flatMap { idx -> [[Int]] in
        let n = numbers[idx]
        let _numbers = Array(numbers.dropFirst(idx + 1))
        return combinations(_numbers, count-1).map { [n] + $0 }
    }
}

func mask(_ digits: [Int], _ indices: [Int], _ digit: Int) -> [Int] {
    var _digits = digits
    for idx in indices {
        _digits[idx] = digit
    }
    return _digits
}

loop: for number in stride(from: 100001, through: Int.max, by: 2) where isPrime(number) {
    let allDigits = digits(number)
    let indices = Array(0...allDigits.count-2) // Cannot be the last digit becase primes have to be odd
    
    for repeatedDigit in (0...9) {
        let repeatedAtIndices = indices.filter { allDigits[$0] == repeatedDigit }
        guard repeatedAtIndices.count >= 3 else { continue }

        for maskLength in (3...repeatedAtIndices.count) {
            for maskIndices in combinations(repeatedAtIndices, maskLength) {
                let maskedNumbers = (0...9).lazy.map {
                    mask(allDigits, maskIndices, $0)
                }.filter { $0[0] > 0 }.map(number(_:))
                
                let maskedPrimes = maskedNumbers.filter(isPrime(_:))
                
                if maskedPrimes.count >= 8 {
                    print(number)
                    break loop
                }
            }
        }
    }
}
