// The decimal number, 585 = 1001001001_2 (binary), is palindromic in both bases.

// Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.

// (Please note that the palindromic number, in either base, may not include leading zeros.)

func binary(_ n: Int) -> String {
    var bits: [Int] = []
    var residue = n
    while residue > 0 {
        bits.append(residue & 1)
        residue >>= 1
    }
    return bits.reversed().map(String.init).joined()
}

func decimal(_ n: Int) -> String {
    String(n)
}

func isPalindrom(_ string: String) -> Bool {
    string == String(string.reversed())
}

func isPalindromic(_ n: Int) -> Bool {
    isPalindrom(decimal(n)) && isPalindrom(binary(n))
}

let numbers = (1...999999).filter(isPalindromic(_:))
let result = numbers.reduce(0, +)
print(result)
