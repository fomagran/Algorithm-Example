import Foundation

var numbers = [82,10,9,72,31,45,60]

extension Array where Element == Int {
    mutating func sortByInsertion(_ startIndex:Int?) -> [Int] {
        let start = startIndex == nil ? 1 : startIndex!
        if start == self.count { return self }
        
        let current = self.remove(at: start)
        var index = 0
        for i in stride(from: start-1, through: 0, by:-1) {
            if current >= self[i] {
                index = i+1
                break
            }
        }
        self.insert(current, at:index)
        return sortByInsertion(start+1)
    }
}

numbers.sortByInsertion(nil)
