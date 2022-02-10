
// We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.

// The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.

// Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.
// HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.

let powersOfTen = [1, 10, 100, 1000, 10000]

func uniq(figures: Int, digits: [Int]) -> [Int] {
    if figures == 1 { return digits.map { $0 } }
    return digits.flatMap { digit -> [Int] in
        let otherDigits = digits.filter { $0 != digit }
        let term = digit * powersOfTen[figures-1]
        return uniq(figures: figures-1, digits: otherDigits).map { term + $0 }
    }
}

func pandigitalProducts(mutliplicants: [Int], multipliers: [Int]) -> [Int] {
    mutliplicants.flatMap { multiplicant -> [Int] in
        multipliers.compactMap { multiplier in
            let product = multiplicant*multiplier
            let identity = "\(multiplicant)\(multiplier)\(product)"
            return identity.count == 9 && !identity.contains("0") && Set(identity).count == 9 
            ? product
            : nil
        }
    }
}

let digits = Array((1...9))
let uniqDigitNumbers: [[Int]] = [[]] + (1...4).map { uniq(figures: $0, digits: digits) }

let products = pandigitalProducts(mutliplicants: uniqDigitNumbers[1], multipliers: uniqDigitNumbers[2...4].flatMap { $0 }) + pandigitalProducts(mutliplicants: uniqDigitNumbers[2], multipliers: uniqDigitNumbers[2...3].flatMap { $0 })

let result = Set(products).reduce(0, +)
print(result)