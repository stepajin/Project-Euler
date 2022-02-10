// Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

//  1634 = 1^4 + 6^4 + 3^4 + 4^4
//  8208 = 8^4 + 2^4 + 0^4 + 8^4
//  9474 = 9^4 + 4^4 + 7^4 + 4^4

// As 1 = 1^4 is not a sum it is not included.

// The sum of these numbers is 1634 + 8208 + 9474 = 19316.

// Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.

func pow(_ base: Int, _ exp: Int) -> Int {
    guard exp > 0 else { return 1 }
    return (1...exp).map { _ in base }.reduce(1, *)
}

func digits(of n: Int) -> [Int] {
    guard n > 0 else { return [] }
    var number = n
    var result: [Int] = []
    while number > 0 {
        let digit = number % 10
        result.insert(digit, at: 0)
        number /= 10 
    }
    return result
}

let powers = (0...9).map { pow($0, 5) }
let maxDigits = (1...Int.max).first { (powers[9] * $0) < (pow(10, $0) - 1) }!
let max = powers[9] * maxDigits

let validNumbers: [Int] = (2...max).compactMap { 
    let sum = digits(of: $0).map { powers[$0] }.reduce(0, +)
    return sum == $0 ? $0 : nil
}
let result = validNumbers.reduce(0, +)
print(result)