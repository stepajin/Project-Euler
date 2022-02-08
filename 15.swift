// Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.

// How many such routes are there through a 20×20 grid?

func printGrid(_ grid: [[Int]]) {
    grid.forEach { print($0) }
}

func gridOfPaths(height: Int, width: Int) -> [[Int]] {
    var grid: [[Int]] = .init(repeating: .init(repeating: 0, count: width+1), count: height+1)
    for column in (0...width).reversed() {
        for row in (0...height).reversed() {
            grid[row][column] = column == width || row == height
            ? 1
            : grid[row+1][column] + grid[row][column+1]
        }
    }
    return grid
}

let grid = gridOfPaths(height: 20, width: 20)
let result = grid[0][0]
print(result)
