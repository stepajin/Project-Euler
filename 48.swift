// The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.

// Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.

func sum(_ a: Int, _ b: Int) -> Int { (a + b) % 10000000000 }
func product(_ a: Int, _ b: Int) -> Int { (a * b) % 10000000000 }
func pow(_ a: Int, _ b: Int) -> Int { (1...b).lazy.map { _ in a }.reduce(1, product(_:_:)) }
func selfPow(_ a: Int) -> Int { pow(a, a) }

let result = (1...1000).map(selfPow(_:)).reduce(0, sum(_:_:))
print(result)
