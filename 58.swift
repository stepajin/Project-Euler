// Sieve of Eratosthenes
// Odd numbers only
func isPrime(_ n: Int) -> Bool {
    struct Map {
        static let isPrime: [Bool] = {
            let bound = 700000000
            var flags = [Bool](repeating: true, count: (bound+1)/2)
            flags[0] = false
            for n in stride(from: 3, through: bound, by: 2) {
                guard flags[(n-1)/2] else { continue }
                for i in stride(from: 3 * n, through: bound, by: 2 * n) {
                    flags[(i-1)/2] = false
                }
            }
            return flags
        }()
    }
    return n % 2 == 0 ? false : Map.isPrime[(n-1)/2]
}

var primesCount = 0
var last = 1
for side in stride(from: 3, through: Int.max, by: 2) {
    let i = side / 2 + 1
    let step = 2 * (i - 1)
    let nums = (1...4).map { n in last + n * step }
    primesCount += nums.filter { isPrime($0) }.count
    let total = (i - 1) * 4 + 1
    let perc = Double(primesCount) / Double(total) * 100
    last = nums[3]
    if perc < 10 {
        print(side)
        break
    }
}