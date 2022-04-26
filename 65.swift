// The square root of 2 can be written as an infinite continued fraction.

// sqrt(2) = 1 + 1 / (2 + 1 / (2 + 1/...))

// The infinite continued fraction can be written, sqrt(2) = [1;(2)], (2) indicates that 2 repeats ad infinitum. In a similar way, sqrt(23) = [4, (1, 3, 1, 8)].

// It turns out that the sequence of partial values of continued fractions for square roots provide the best rational approximations. Let us consider the convergents for sqrt(2).

// 1 + 1/2 = 3/2
// 1 + 1 / (2 + 1/2) = 7/5

// Hence the sequence of the first ten convergents for sqrt(2) are:

// 1, 3/2, 7/5, 17/12, 41/29, 99/70, 239/169, 577/408, 1393/985, 3363/2378

// What is most surprising is that the important mathematical constant,
// e = [2; 1,2,1,1,4,1,1,6,1,...1,2k,1..].

// The first ten terms in the sequence of convergents for e are:
// 2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536

// The sum of digits in the numerator of the 10th convergent is 1 + 4 + 5 + 7 = 17.

// Find the sum of digits in the numerator of the 100th convergent of the continued fraction for e. 

import Foundation

typealias Fraction = (Double, Double)
typealias ContinuedFraction = (Int, [Int])

func digits(_ d: Double) -> [Int] {
   String(format: "%.0f", d).map(String.init).compactMap(Int.init)
}

func reverse(_ fraction: Fraction) -> Fraction {
   Fraction(fraction.1, fraction.0)
}

func asFraction(_ n: Int) -> Fraction {
   (Double(n), Double(1))
}

func add(_ a: Fraction, _ b: Fraction) -> Fraction {
   (a.0 * b.1 + b.0 * a.1, a.1 * b.1)
}

func convergent(_ c: ContinuedFraction) -> Fraction {
   (c.1.dropLast().reversed() + [c.0]).reduce(asFraction(c.1.last!)) {
      add(asFraction($1), reverse($0))
   }
}

let e = (2, [1, 2] + (1...97).map { $0 % 3 == 0 ? 2 * ($0 / 3 + 1) : 1 })
let result = digits(convergent(e).0).reduce(0, +)
print(result)
