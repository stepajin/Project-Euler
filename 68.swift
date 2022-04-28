// Consider the following "magic" 3-gon ring, filled with the numbers 1 to 6, and each line adding to nine.

//     4
//      \
//       3
//       | \
//       1--2--6
//       |
//       5

// Working clockwise, and starting from the group of three with the numerically lowest external node (4,3,2 in this example), each solution can be described uniquely. For example, the above solution can be described by the set: 4,3,2; 6,2,1; 5,1,3.

// It is possible to complete the ring with four different totals: 9, 10, 11, and 12. There are eight solutions in total.

// Total     Solution Set
//   9     4,2,3; 5,3,1; 6,1,2
//   9     4,3,2; 6,2,1; 5,1,3
//  10     2,3,5; 4,5,1; 6,1,3
//  10     2,5,3; 6,3,1; 4,1,5
//  11     1,4,6; 3,6,2; 5,2,4
//  11     1,6,4; 5,4,2; 3,2,6
//  12     1,5,6; 2,6,4; 3,4,5
//  12     1,6,5; 3,5,4; 2,4,6

// By concatenating each group it is possible to form 9-digit strings; the maximum string for a 3-gon ring is 432621513.

// Using the numbers 1 to 10, and depending on arrangements, it is possible to form 16- and 17-digit strings. What is the maximum 16-digit string for a "magic" 5-gon ring?

func combinations<T>(_ elements: [T], _ count: Int) -> [[T]] {
    guard count > 1 else { return elements.map { [$0] } }
    return elements.indices.dropLast(count-1).flatMap { idx -> [[T]] in
        let n = elements[idx]
        let otherElements = Array(elements.dropFirst(idx + 1))
        return combinations(otherElements, count-1).map { [n] + $0 }
    }
}

typealias Line = (Int, Int, Int)

func tryToBuildGraph(_ lines: [Line]) -> String? {
    let firstNodes = Set(lines.map { $0.1 })
    let secondNodes = Set(lines.map { $0.2 })
    guard firstNodes.count == 5 && firstNodes == secondNodes else { return nil }
    var _lines = lines.sorted { $0.0 <= $1.0 }
    var line = _lines.removeFirst()
    var graph = [line]
    
    while !_lines.isEmpty {
        guard let index = _lines.firstIndex(where: { $0.1 == line.2 }) else { return nil }
        line = _lines.remove(at: index)
        graph.append(line)
    }
    return graph.flatMap { [$0, $1, $2] }.map(String.init).joined()
}

let digits = Set(1...10)
let allLines = digits.flatMap { a in digits.subtracting([a, 10]).flatMap { b in digits.subtracting([a, b, 10]).map { c in (a, b, c) } } }
let linesPerSum = Dictionary(grouping: allLines) { $0 + $1 + $2 }

let graphs: [String] = linesPerSum.flatMap { _, lines -> [String] in
    let possibleLeaves = Set(lines.map { $0.0 })
    let possibleInnerNodes = Set(lines.map { $0.1 })
    
    guard possibleLeaves.count >= 5
        && possibleLeaves.contains(10)
        && possibleLeaves.union(possibleInnerNodes).count == 10 else { return [] }
    
    let leavesCombinations = combinations(Array(possibleLeaves), 5).map(Set.init).filter { $0.contains(10) }
    
    return leavesCombinations.flatMap { leaves -> [String] in
        let innerNodes = possibleInnerNodes.subtracting(Set(leaves))
        let validLines = lines.filter {
            leaves.contains($0)
                && innerNodes.contains($1)
                && innerNodes.contains($2)
        }
        
        let linesPerLeaf = Array(Dictionary(grouping: validLines) { $0.0 }.values)
        guard linesPerLeaf.count == 5 else { return [] }
        
        let allLinesCombinations: [[Line]] = linesPerLeaf[0].flatMap { a in linesPerLeaf[1].flatMap { b in linesPerLeaf[2].flatMap { c in linesPerLeaf[3].flatMap { d in linesPerLeaf[4].map { e in [a, b, c, d, e] } } } } }

        return allLinesCombinations.compactMap(tryToBuildGraph(_:))
    }
}

let result = graphs.max()!
print(result)
