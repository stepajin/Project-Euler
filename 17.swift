// If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

// If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?

// NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.

struct Numeral: CustomDebugStringConvertible {
	private static var dictionary: [Int: String] = [
		1: "one",
		2: "two",
		3: "three",
		4: "four",
		5: "five",
		6: "six",
		7: "seven",
		8: "eight",
		9: "nine",
		10: "ten",
		11: "eleven",
		12: "twelve",
		13: "thirteen",
		14: "fourteen",
		15: "fifteen",
		16: "sixteen",
		17: "seventeen",
		18: "eighteen",
		19: "nineteen",
		20: "twenty",
		30: "thirty",
		40: "forty",
		50: "fifty",
		60: "sixty",
		70: "seventy",
		80: "eighty",
		90: "ninety",
		100: "hundred",
		1000: "thousand"
	]
	
	let numeral: String
	
	init(_ number: Int) {
		if number <= 20 {
			numeral = Numeral.dictionary[number]!
		} else if number <= 99 {
			let ones = number % 10
			let tens = number - ones
			numeral = ones == 0
				? Numeral.dictionary[tens]!
				: Numeral.dictionary[tens]! + "-" + Numeral.dictionary[ones]!
		} else if number <= 999 {
			let tens = number % 100
			let hundreds = number / 100
			numeral = tens == 0
				? Numeral.dictionary[hundreds]! + " " + Numeral.dictionary[100]!
				: Numeral.dictionary[hundreds]! + " " + Numeral.dictionary[100]! + " and " + Numeral(tens).numeral
		} else if number == 1000 {
			numeral = Numeral.dictionary[1]! + " " + Numeral.dictionary[1000]!
		} else {
			numeral = ""
		}
	}
	
	var debugDescription: String { numeral }
}

extension Int {
	var numeral: String { Numeral(self).numeral }
}

let result = (1...1000).map { $0.numeral }.joined().filter { $0 != " " && $0 != "-" }.count
print(result)
