// An irrational decimal fraction is created by concatenating the positive integers:

// 0.123456789101112131415161718192021...

// It can be seen that the 12th digit of the fractional part is 1.

// If dn represents the nth digit of the fractional part, find the value of the following expression.

// d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000

let powersOfTen: [Int] = [1] + (1...10).map { (1...$0).map { _ in 10 }.reduce(1, *) }
let countsPerLength: [Int] = [0, 9] + (2...10).map { powersOfTen[$0] - powersOfTen[$0-1] }
let digitsCountsPerLength: [Int] = (0...10).map { $0 * countsPerLength[$0] }
let prefixes = (0...10).map { digitsCountsPerLength.prefix($0+1).reduce(0, +) }

func digits(_ n: Int) -> [UInt8] {
    String(n).map(String.init).compactMap(UInt8.init)
}

func digit(_ n: Int) -> UInt8 {
    guard let length = prefixes.firstIndex(where: { $0 >= n }) else { return 0 }
    let nthDigitOfLength = n - prefixes[length-1]
    let nthNumberOfLength = (nthDigitOfLength + (nthDigitOfLength % length)) / length
    let number = powersOfTen[length-1] + nthNumberOfLength - 1
    let digitIndex = (nthDigitOfLength-1) % length
    return digits(number)[digitIndex]
}

let result = [1, 10, 100, 1000, 10000, 100000, 1000000].map { digit($0) }.map(Int.init).reduce(1, *)
print(result)

