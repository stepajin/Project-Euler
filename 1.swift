// If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

// Find the sum of all the multiples of 3 or 5 below 1000.

struct Multiplies: Sequence, IteratorProtocol {
    private let base: Int
    private let max: Int
    private var last: Int = 0

    init(of base: Int, max: Int) {
        self.base = base
        self.max = max
    }

    mutating func next() -> Int? {
        let result = last + base
        guard result < max else { return nil }
        last = result
        return result
    }
}

let result = Multiplies(of: 3, max: 1000).reduce(0, +)
    + Multiplies(of: 5, max: 1000).lazy.filter { $0 % 3 != 0 }.reduce(0, +)
print(result)
