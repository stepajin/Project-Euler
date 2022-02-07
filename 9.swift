// A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
// a2 + b2 = c2

// For example, 32 + 42 = 9 + 16 = 25 = 52.

// There exists exactly one Pythagorean triplet for which a + b + c = 1000.
// Find the product abc.

func findTripletProduct(sum: Int) -> Int {
    for a in (1...sum/3) {
        for b in (a+1...sum/2) {
            let c = sum - a - b
            if c * c == a * a + b * b {
                return a * b * c
            }
        }
    }
    return 0
}

let result = findTripletProduct(sum: 1000)
print(result)
