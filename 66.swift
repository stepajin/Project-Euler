// Consider quadratic Diophantine equations of the form:

// x^2 – Dy^2 = 1

// For example, when D=13, the minimal solution in x is 649^2 – 13×180^2 = 1.

// It can be assumed that there are no solutions in positive integers when D is square.

// By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the following:

// 3^2 – 2×2^2 = 1
// 2^2 – 3×1^2 = 1
// 9^2 – 5×4^2 = 1
// 5^2 – 6×2^2 = 1
// 8^2 – 7×3^2 = 1

// Hence, by considering minimal solutions in x for D ≤ 7, the largest x is obtained when D=5.

// Find the value of D ≤ 1000 in minimal solutions of x for which the largest value of x is obtained.

func hasSquareRoot(_ x: Int) -> Bool {
    let sqrt = Double(x).squareRoot()
    return sqrt == Double(Int(sqrt))
}

func isOdd(_ x: Int) -> Bool {
    x % 2 != 0
}

// notation: aa = a(n+1); a = a(n)
// bb = (x - a * a) / b
// nn = (sqrt(x) / a) / bb) -> Int
// aa = -a - (nn * bb)
func f(x: Int, a: Int, b: Int) -> (n: Int, a: Int, b: Int) {
    let bb = (x - a * a) / b
    let nn = Int((Double(x).squareRoot() - Double(a)) / Double(bb))
    let aa = -a - (nn * bb)
    return (n: nn, a: aa, b: bb)
}

func continuedFractionOfSqrt(_ x: Int) -> [Int] {
    if hasSquareRoot(x) { return [] }
    
    var n = Int(Double(x).squareRoot())
    var a = -n
    var b = 1
    let initialValues = (a, b)
    var result = [n]
    
    for _ in (1...) {
        (n, a, b) = f(x: x, a: a, b: b)
        result += [n]
        if (a, b) == initialValues { return result }
    }
    return []
}

// Pell equation sequence
func p(_ n: Int, _ a: [Int]) -> Double {
    var cache: [Int: Double] = [:]
    
    func _p(_ n: Int) -> Double {
        switch n {
        case -1:
            return 1
        case 0:
            return Double(a[0])
        default:
            if let result = cache[n] { return result }
            let index = n < a.count ? n : (n % a.count) + 1
            let result = Double(a[index]) * _p(n-1) + _p(n-2)
            cache[n] = result
            return result
        }
    }
    
    return _p(n)
}

func fundamentalX(d: Int) -> Double {
    let c = continuedFractionOfSqrt(d)
    let period = c.count-1
    return isOdd(period) ? p(2*period-1, c) : p(period-1, c)
}

let result = (2...1000)
    .filter { !hasSquareRoot($0) }
    .map { ($0, fundamentalX(d: $0)) }
    .max { $0.1 <= $1.1 }!.0
print(result)
