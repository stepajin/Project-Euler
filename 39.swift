// If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.

// {20,48,52}, {24,45,51}, {30,40,50}

// For which value of p ≤ 1000, is the number of solutions maximised?

// a^2 + b^2 = c^2
// a + b + c = p
// => b = (2ap - p^2) / (2a - 2p)
// => c = p - a - b

typealias Triangle = (a: Int, b: Int, c: Int)

func triangles(p: Int) -> [Triangle] {
    var solutions: [Triangle] = []
    for a in (1...p/3) {
        let b = (2*a*p - p*p)/(2*a - 2*p)
        guard b >= a else { continue }
        let c = p - a - b
        if c >= b, a*a + b*b == c*c { 
            solutions.append(Triangle(a: a, b: b, c: c))
        }
    }
    return solutions
}

let result = (10...1000).map { ($0, triangles(p: $0).count) }.max { $0.1 <= $1.1 }!.0
print(result)
