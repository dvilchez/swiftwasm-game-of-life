import LifeGame

class App: BoardUpdater {
    var cells: [[Cell]]
    let rule: Rule

    init(initial: [[Cell]], rule: Rule) {
        self.cells = initial
        self.rule = rule
    }

    func update(at point: Point, cell: Cell) {
        cells[point.y][point.x] = cell
    }

    func iterate() {
        LifeGame.iterate(cells, updater: self, rule: rule)
    }

    func serializeCells() -> [[Bool]] {
        (0..<cells.count).map { x in
            (0..<cells[x].count).map { y in
                cells[x][y].live
            }
        }
    }
}

func parseCells(cells: [[Bool]]) -> [[Cell]] {
    (0..<cells.count).map { x in
        (0..<cells[x].count).map { y in
            Cell(live: cells[x][y])
        }
    }
}


@_cdecl("iterate")
public func iterate(cells: [[Bool]], liveColor: String, rule: String) -> [[Bool]] {
    let rule = try! Rule(ruleString: rule)
    let lifeGame = App(initial: parseCells(cells: cells), rule: rule)

    lifeGame.iterate()

    return lifeGame.serializeCells()
}
