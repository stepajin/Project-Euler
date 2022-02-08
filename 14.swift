// The following iterative sequence is defined for the set of positive integers:

// n → n/2 (n is even)
// n → 3n + 1 (n is odd)

// Using the rule above and starting with 13, we generate the following sequence:
// 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

// It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

// Which starting number, under one million, produces the longest chain?

//NOTE: Once the chain starts the terms are allowed to go above one million.

var collatzCache: [Int: Int] = [1: 1, 2: 2, 4: 3]

func collatz(_ start: Int) -> Int {
    if [4, 2, 1].contains(start) { return 3 }
    if let lenght = collatzCache[start] { return lenght }
    
    var chain: [Int] = []
    var nextElement = start
    while collatzCache[nextElement] == nil {
        chain.append(nextElement)
        nextElement = nextElement % 2 == 0 ? nextElement / 2 : 3 * nextElement + 1
    }
    
    guard let subcount = collatzCache[nextElement] else { return 0 }
    for (index, element) in chain.enumerated() {
        collatzCache[element] = chain.count - index + subcount
    }
    return chain.count + subcount
}

var result = 0
var max = 0
for i in (1...1000000) {
    let length = collatz(i)
    if length > max {
        result = i
        max = length
    }
}

print(result)