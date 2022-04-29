// Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of numbers less than n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6.

// n    Relatively Prime    φ(n)     n/φ(n)
// 2    1                    1         2
// 3    1,2                  2         1.5
// 4    1,3                  2         2
// 5    1,2,3,4              4         1.25
// 6    1,5                  2         3
// 7    1,2,3,4,5,6          6         1.1666...
// 8    1,3,5,7              4         2
// 9    1,2,4,5,7,8          6         1.5
// 10   1,3,7,9              4         2.5

// It can be seen that n=6 produces a maximum n/φ(n) for n ≤ 10.

// Find the value of n ≤ 1,000,000 for which n/φ(n) is a maximum.

// (pi - 1) * pi^(k-1)
func φ(_ max: Int) -> [Int] {
    var euler = (0...max).map { _ in 1 }
    for factor in (2...max) where euler[factor] == 1 {
        for k in stride(from: factor, through: max, by: factor) {
            euler[k] *= factor-1
        }
        var pow = factor * factor
        while pow <= max {
            for k in stride(from: pow, through: max, by: pow) {
                euler[k] *= factor
            }
            pow *= factor
        }
    }
    return euler
}

let max = 1000000
let phi = φ(max)

func ratio(_ n: Int) -> Double { Double(n) / Double(phi[n]) }

let result = (2...max).max { ratio($0) <= ratio($1) }!
print(result)
