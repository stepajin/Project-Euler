// The cube, 41063625 (345^3), can be permuted to produce two other cubes: 56623104 (3843) and 66430125 (4053). In fact, 41063625 is the smallest cube which has exactly three permutations of its digits which are also cube.

// Find the smallest cube for which exactly five permutations of its digits are cube.

var permutations: [String: [Int]] = [:]

for n in (100...Int.max) {
    let cube = n*n*n
    let key = String(String(cube).sorted())
    let perms = permutations[key, default: []] + [cube]
    permutations[key] = perms
    
    if perms.count >= 5 {
        print(perms[0])
        break
    }
}