// In the United Kingdom the currency is made up of pound (£) and pence (p). There are eight coins in general circulation:

//  1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), and £2 (200p).

// It is possible to make £2 in the following way:

//  1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p

// How many different ways can £2 be made using any number of coins?

func combinations(sum: Int, coins: [Int]) -> Int {
    guard let coin = coins.last else { return 0 }
    if coin == 1 { return 1 }
    let smallerCoins = Array(coins.dropLast())
    return (0...sum/coin).map { factor -> Int in
        let residue = sum - factor * coin
        return residue == 0 ? 1 : combinations(sum: residue, coins: smallerCoins)
    }.reduce(0, +)
}

let coins = [1, 2, 5, 10, 20, 50, 100, 200]

let result = combinations(sum: 200, coins: coins)
print(result)