// The first two consecutive numbers to have two distinct prime factors are:

// 14 = 2 × 7
// 15 = 3 × 5

// The first three consecutive numbers to have three distinct prime factors are:

// 644 = 2^2 × 7 × 23
// 645 = 3 × 5 × 43
// 646 = 2 × 17 × 19

// Find the first four consecutive integers to have four distinct prime factors each. What is the first of these numbers?

var factors = [[Int]](repeating: [], count: 200001)
var cnt = 0
var result = 0
for i in (2...200000) {
    cnt = factors[i].count == 4 ? cnt + 1 : 0
    if cnt == 4 {
        result = i - 3
        break
    }
    guard factors[i].isEmpty else { continue }
    for k in stride(from: i, through: 200000, by: i) {
        factors[k].append(i)
    }
}
print(result)
