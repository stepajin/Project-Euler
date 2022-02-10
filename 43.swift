//The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.
//
//Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:
//
//  d2d3d4=406 is divisible by 2
//  d3d4d5=063 is divisible by 3
//  d4d5d6=635 is divisible by 5
//  d5d6d7=357 is divisible by 7
//  d6d7d8=572 is divisible by 11
//  d7d8d9=728 is divisible by 13
//  d8d9d10=289 is divisible by 17
//
//Find the sum of all 0 to 9 pandigital numbers with this property.

func pandigitalNumbers(from digits: [UInt8]) -> [Int] {
    if digits.count == 1 { return [Int(digits[0])] }
    return (0...digits.count-1).reversed().flatMap { index -> [Int] in
        let digit = digits[index]
        var other = digits
        other.remove(at: index)
        return pandigitalNumbers(from: other).compactMap { 
            let s = String($0)
            return s.count == digits.count-1
                ? Int("\(digit)\(s)")
                : Int("\(digit)0\(s)")
        }
    }
}

func isSubStringDivisible(_ number: Int) -> Bool {
    ((number % 1000000000)/1000000) % 2 == 0
        && ((number % 100000000)/100000) % 3 == 0
        && ((number % 10000000)/10000) % 5 == 0
        && ((number % 1000000)/1000) % 7 == 0
        && ((number % 100000)/100) % 11 == 0
        && ((number % 10000)/10) % 13 == 0
        && ((number % 1000)) % 17 == 0
}

let numbers = pandigitalNumbers(from: [0, 1, 2, 3, 4, 5, 6 , 7, 8, 9]).filter { $0 > 1000000000 }.filter(isSubStringDivisible(_:))
print(numbers.count)

let result = numbers.reduce(0, +)
print(result)
