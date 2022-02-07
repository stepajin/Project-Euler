// The sum of the squares of the first ten natural numbers is 385

// The square of the sum of the first ten natural numbers is 3025

// Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 2640

// Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

let sumOfSquares = (1...100).reduce(0) { acc, elem in acc + elem * elem }
let sum = (1...100).reduce(0, +)
let squareOfSum = sum * sum
let result = squareOfSum - sumOfSquares

print(result)
