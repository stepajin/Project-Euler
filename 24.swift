// A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

// 012   021   102   120   201   210

// What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

func factorial(_ number: Int) -> Int {
	(1...number).reduce(1, *)
}

func permutation<T>(n: Int, of elements: [T]) -> [T] {
	if elements.count == 1 { return elements }
	let subpermutations = factorial(elements.count - 1)
	let elementIndex = n % subpermutations == 0 ? n / subpermutations - 1 : n / subpermutations
	let element = elements[elementIndex]
	var subelements = elements
	subelements.remove(at: elementIndex)
	let subindex = n - elementIndex * subpermutations
	return [element] + permutation(n: subindex, of: subelements)
}

let elements: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
let result = permutation(n: 1000000, of: elements).map { "\($0)" }.joined()
print(result)
