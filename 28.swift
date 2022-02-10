// Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:

// 21 22 23 24 25
// 20  7  8  9 10
// 19  6  1  2 11
// 18  5  4  3 12
// 17 16 15 14 13

// It can be verified that the sum of the numbers on the diagonals is 101.

// What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?

// Last number in the distance d is:
// 1 + (4 * step_1 + 4 * step_2 ... + 4 * step_d)
// 1 + 4 * (step_1 + step_2 + ... + step_d)
// 1 + 4 * (2 + 4 ... + step_d)
// 1 + 4 * (2 + 2 * 2 + ... + 2 * d)
// 1 + 4 * 2 (1 + 2 + ... + d)
// 1 + 4 * 2 (d * (1 + d) / 2)
// 1 + 4 * d * (1 + d)
func diagonal(diameter: Int) -> [Int] {
    [1] + (1...diameter/2).flatMap { distance -> [Int] in 
        let last = 1 + 4 * distance * (1 + distance)
        let step = 2 * distance
        return (0...3).reversed().map { last - step * $0 }
    }
}

let result = diagonal(diameter: 1001).reduce(0, +)
print(result)