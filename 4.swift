
// A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

// Find the largest palindrome made from the product of two 3-digit numbers.

func reversed(_ n: Int) -> Int {
	var rev = 0
	var div = n
	while div > 0 {
		rev = rev * 10 + div % 10
		div /= 10		
	}
	return rev
}

func isPalindrome(_ n: Int) -> Bool {
	n == reversed(n)
}

var result = 0

for i in (100...999).reversed() {
	for k in (i...999).reversed() {
		let product = i * k
		if product > result && isPalindrome(product) {
			result = product
		}
	}
}

print(result)
