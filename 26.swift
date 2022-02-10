// A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:

//  1/2	= 	0.5
//  1/3	= 	0.(3)
//  1/4	= 	0.25
//  1/5	= 	0.2
//  1/6	= 	0.1(6)
//  1/7	= 	0.(142857)
//  1/8	= 	0.125
//  1/9	= 	0.(1)
//  1/10	= 	0.1 

// Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.

// Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.

struct Fraction: CustomDebugStringConvertible {
    let digits: [Int]
    let cycle: Int
    let denominator: Int

    var debugDescription: String {
        var desc = "0."
        desc += digits[0..<digits.count-cycle].map(String.init).joined()
        if cycle == 0 { return desc }
        desc += "("
        desc += digits[digits.count-cycle..<digits.count].map(String.init).joined() 
        desc += ")"
        return desc
    }
    
    private init(digits: [Int], cycle: Int, d: Int) {
        self.digits = digits
        self.cycle = cycle
        self.denominator = d
    }
    
    init(d: Int) {
        var numerator = 10
        var digits: [Int] = []
        var residues: [Int] = []
        while true {
            let div = numerator / d
            let residue = numerator - div * d
            numerator = residue * 10
            if residue == 0 {
                digits.append(div)
                self.init(digits: digits, cycle: 0, d: d)
                return
            } else if let index = residues.firstIndex(of: residue) {
                self.init(digits: digits, cycle: digits.count - index, d: d)
                return
            } else {
                digits.append(div)
                residues.append(residue)
            }
        }
        self.init(digits: [], cycle: 0, d: d)
    }
}

let result = (2...1000).map { Fraction(d: $0) }.max { $0.cycle <= $1.cycle }!.denominator
print(result)