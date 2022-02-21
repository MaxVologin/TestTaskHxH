import Foundation

class SortedArrayOfArraysGenerator: SortedArrayOfArraysGeneratorable {
    
    public func generate(n size: Int) ->  Result<[[Int]], InputError> {
        guard size > 0 else {
            return .failure(.invalidValue)
        }
        let arrayOfArrays = createSomeArrays(sizeArrayOfArrays: size)
        let sortedArrayOfArrays = sortArrayOfArrays(arrayOfArrays: arrayOfArrays)
        return .success(sortedArrayOfArrays)
    }
    
    private func createArray(size: Int) -> [Int] {
        var array = [Int]()
        for _ in 0..<size {
            let randomNumber = Int(arc4random())
            array.append(randomNumber)
        }
        return array
    }
    
    private func createSomeArrays(sizeArrayOfArrays: Int) -> [[Int]] {
        var arrayOfArrays = [[Int]]()
        let arraySizes = generateUniqueArraySizes(sizeArrayOfArrays: sizeArrayOfArrays)
        for arraySize in arraySizes {
            let newArray = createArray(size: arraySize)
            arrayOfArrays.append(newArray)
        }
        return arrayOfArrays
    }
    
    private func generateUniqueArraySizes(sizeArrayOfArrays: Int) -> Set<Int>{
        var arraySizes = Set<Int>()
        while (arraySizes.count < sizeArrayOfArrays) {
            let arraySize = Int(arc4random())
            arraySizes.insert(arraySize)
        }
        return arraySizes
    }
    
    private func sortArrayOfArrays(arrayOfArrays: [[Int]]) -> [[Int]] {
        return arrayOfArrays.enumerated().map { (index, element) in
            if index % 2 == 0 {
                return element.sorted {$0 > $1}
            } else {
                return element.sorted {$0 < $1}
            }
        }
    }
}

enum InputError: Error {
    case invalidValue
}

extension InputError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .invalidValue:
            return "You entered the invalid value"
        }
    }
}

protocol SortedArrayOfArraysGeneratorable {
    func generate(n size: Int) ->  Result<[[Int]], InputError>
}
