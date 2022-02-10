// The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.

// We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

// There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.

// If the product of these four fractions is given in its lowest common terms, find the value of the denominator.

func greatestCommonDivisor(_ a: Int, _ b: Int) -> Int {
    (1...min(a, b)).reversed().first { a % $0 == 0 && b % $0 == 0 }!
}

func lowestCommonTerms(_ fraction: (Int, Int)) -> (Int, Int) {
    let gcd = greatestCommonDivisor(fraction.0, fraction.1)
    return (fraction.0/gcd, fraction.1/gcd)
}

let allFractions: [(Int, Int)] = (10...98).flatMap { numerator -> [(Int, Int)] in
    (numerator+1...99).map { denominator in (numerator, denominator) }
}

let fractions: [(Int, Int)] = allFractions.filter { numerator, denominator in
    if numerator % 10 == 0 && denominator % 10 == 0 { return false }
    let (a, b) = (Double(numerator / 10), Double(numerator % 10))
    let (c, d) = (Double(denominator / 10), Double(denominator % 10))
    let fraction = Double(numerator) / Double(denominator)
    return (c != 0 && (a == c && b / d == fraction) || (a == d && b / c == fraction)) 
        || (d != 0 && (b == c && a / d == fraction) || (b == d && a / c == fraction))
}

let product = fractions.map { lowestCommonTerms($0) }.reduce((1, 1)) { ($0.0 * $1.0, $0.1 * $1.1) }
let result = lowestCommonTerms(product).1
print(result)