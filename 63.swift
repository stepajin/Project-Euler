//The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the 9-digit number, 134217728=8^9, is a ninth power.

//How many n-digit positive integers exist which are also an nth power?

let bases = (1...9).map(Double.init)
var powers = bases
var min = 1.0
var result = 0

for _ in 1... {
    let add = powers.filter((min..<10*min).contains(_:)).count
    guard add > 0 else { break }
    result += add
    powers = zip(powers, bases).map(*)
    min *= 10
}

print(result)
