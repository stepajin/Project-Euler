// All square roots are periodic when written as continued fractions and can be written in the form:

// sqrt(n) = a0 + 1 / (a1 + (1 / a2 + (1 / a3+...)))

// For example, let us consider

// sqrt(23) = 4 + sqrt(23) - 4 = 4 + 1 / (1 / 1 / (sqrt(23) - 4))

// If we continue we would get the following expansion:

// sqrt(23) = 4 + 1 / ( 1 + 1 / ( 3 + 1 / ( 1 + 1 / (8 + ...))))

// It can be seen that the sequence is repeating. For conciseness, we use the notation sqrt(23) = [4;(1,3,1,8)], to indicate that the block (1,3,1,8) repeats indefinitely.

// Exactly four continued fractions, for n <= 13, have an odd period.

// How many continued fractions for n <= 10000 have an odd period?

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

func periodLength(_ x: Int) -> Int {
	if hasSquareRoot(x) { return 0 }
	
	var n = Int(Double(x).squareRoot())
	var a = -n
	var b = 1
	let initialValues = (a, b)
	
	for i in (1...) {
		(n, a, b) = f(x: x, a: a, b: b)
		if (a, b) == initialValues { return i }
	}
	return 0
}

let result = (2...10000).lazy.map(periodLength(_:)).filter(isOdd(_:)).count
print(result)
