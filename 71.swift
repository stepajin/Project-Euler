// Consider the fraction, n/d, where n and d are positive integers. If n<d and HCF(n,d)=1, it is called a reduced proper fraction.

// If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:

// 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8

// It can be seen that 2/5 is the fraction immediately to the left of 3/7.

// By listing the set of reduced proper fractions for d ≤ 1,000,000 in ascending order of size, find the numerator of the fraction immediately to the left of 3/7.

func ceil(_ a: Double) -> Int {
    let int = Int(a)
    return a == Double(int) ? int : int + 1
}

func gcd(_ a: Int, _ b: Int) -> Int {
    if a == b { return a }
    if a == 1 || b == 1 { return 1 }
    return a > b ? gcd(a-b, b) : gcd(a, b-a)
}

let bound = 1000000
let fraction = 3.0 / 7.0
var max = 0.0
var result = 0

for d in stride(from: bound, through: 2, by: -1) {
    let n = Int(Double(d) * fraction)
    let f = Double(n) / Double(d)
    guard f > max, d != 7, gcd(d, n) == 1 else { continue }
    max = f
    result = n
}
print(result)
