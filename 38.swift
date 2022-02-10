

// Take the number 192 and multiply it by each of 1, 2, and 3:

//  192 × 1 = 192
//  192 × 2 = 384
//  192 × 3 = 576

// By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)

// The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).

// What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1?

func concatenatedProduct(_ number: Int, n: Int) -> Int {
    let products: [Int] = (1...n).map { $0 * number }
    let string = products.map(String.init).joined()
    return Int(string) ?? .max
}

func isPandigital(_ number: Int) -> Bool {
    let string = String(number)
    return !string.contains("0") && string.count == Set(string).count
}

var result = 0
for i in (1...9999) {
    for n in (1...9) {
        let product = concatenatedProduct(i, n: n)
        if product < 1000000 { 
            continue
        }
        if product <= 987654321, isPandigital(product), product > result {
            result = product
        }
        break
    }
}

print(result)
