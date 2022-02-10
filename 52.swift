// It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.

// Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.

let result = (0...Int.max).lazy.map { Int("1\($0)")! }.first { i in
    let str = String(i).sorted()
    return (2...6).reversed().allSatisfy {
        str == String($0 * i).sorted()
    }
}!

print(result)