// 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

// Find the sum of all numbers which are equal to the sum of the factorial of their digits.

// Note: As 1! = 1 and 2! = 2 are not sums they are not included.

var factorials: [Int] = [1]
for i in (1...9) { 
    factorials.append(i * factorials[i-1]) 
}

var digits: [Int] = [0]
var digit = 3
var number = 3
var sum = 2
var numbers: [Int] = []

while number < 1000000 {
    if digit == 0 {
        var index = digits.count - 1
        while (index >= 0 && digits[index] == 9) {
            sum = sum - factorials[9] + factorials[0]
            digits[index] = 0
            index -= 1
        }
        if index >= 0 {
            sum = sum - factorials[digits[index]] + factorials[digits[index] + 1]
            digits[index] += 1			
        } else {
            sum += factorials[1]
            digits.insert(1, at: 0)
        }
    } else {
        sum = sum - factorials[digit-1] + factorials[digit]
        digits[digits.count-1] = digit
    }	
    if number == sum {
        numbers.append(number)
    }	
    number += 1
    digit = (digit + 1) % 10
}

let result = numbers.reduce(0, +)
print(result)
