import Foundation

var numbers:[Int] = [4,1,7,5,3,2,6]

extension Array where Element == Int{
    
    mutating func sortByMerge() -> [Element] {
        return divide(self)
    }
    
    private func divide(_ list:[Element]) -> [Element] {
        if list.count <= 1 { return list }
        let mid:Int = list.count/2
        let left:[Element] = Array(list[0..<mid])
        let right:[Element] = Array(list[mid..<list.count])
        return merge(divide(left), divide(right))
    }

    private func merge(_ left:[Element],_ right:[Element]) -> [Element] {
        var l:[Element] = left
        var r:[Element] = right
        var list:[Element] = []
        
        while !l.isEmpty && !r.isEmpty {
            if l.first! < r.first! {
                list.append(l.removeFirst())
            }else {
                list.append(r.removeFirst())
            }
        }
        list.append(contentsOf: l+r)
        return list
    }
}

numbers.sortByMerge()
