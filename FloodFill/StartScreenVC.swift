//
//  StartScreenVC.swift
//  FloodFill
//
//  Created by Alam Monroy on 20/06/23.
//

import UIKit

class StartScreenVC: UIViewController {
    
    let stackView = UIStackView()
    let gridSize = 6
    var numbers = [[Int]]()
    var numbersView = [[NumberTileView]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupGrid()
    }
    
    func setupUI() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupGrid() {
        numbers = Array(repeating: Array(repeating: 0, count: gridSize), count: gridSize)
        numbersView = Array(repeating: Array(repeating: NumberTileView(number: 0, index: [0,0]), count: gridSize), count: gridSize)
        for row in 0..<gridSize {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.alignment = .fill
            rowStackView.distribution = .fillEqually
            stackView.addArrangedSubview(rowStackView)
            
            for col in 0..<gridSize {
                let number = Int.random(in: 0...5)
                numbers[row][col] = number
                
                let tileView = NumberTileView(number: number, index: [row, col])
                numbersView[row][col] = tileView
                rowStackView.addArrangedSubview(tileView)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tileTapped(_:)))
                tileView.addGestureRecognizer(tapGesture)
                tileView.isUserInteractionEnabled = true
                tileView.tag = number
            }
        }
    }
    
    @objc func tileTapped(_ gesture: UITapGestureRecognizer) {
        guard let tileView = gesture.view as? NumberTileView else { return }
        tileView.setSelected()
        floodFill(startTile: tileView)
    }
    
    func floodFill(startTile: NumberTileView) {
        let value = startTile.tag
        let index = startTile.getIndex()
        var newIndex = [[Int]]()
        newIndex.append([index.x, index.y])
        repeat {
            newIndex += findNeighbors(index: newIndex[0], value: value)
            if newIndex.indices.contains(0) {
                newIndex.remove(at: 0)
            }
        } while !newIndex.isEmpty
    }
    
    func findNeighbors(index: [Int], value: Int) -> [[Int]] {
        let x = [1, 1, 1, 0, 0, -1, -1, -1]
        let y = [-1, 0, +1, -1, 1, -1, 0, 1]
        var newSelected = [[Int]]()
        for i in 0...7 {
            let xIndex = index[0] + x[i]
            let yIndex = index[1] + y[i]
            
            if numbers.indices.contains(xIndex) && numbers[xIndex].indices.contains(yIndex) {
                if value == numbers[xIndex][yIndex] {
                    if !numbersView[xIndex][yIndex].isSelected() {
                        numbersView[xIndex][yIndex].setSelected()
                        newSelected.append([xIndex, yIndex])
                    }
                }
            }
            
        }
        return newSelected
    }
}
