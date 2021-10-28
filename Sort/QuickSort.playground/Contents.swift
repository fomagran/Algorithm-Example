var numbers:[Int] = [9,1,8,3,2,10,4,7,5,6]

extension Array where Element == Int{
    
    enum Pivot:Int {
        case first
        case middle
        case last
        case random
        case median
    }
    
    mutating func sortByQuick(pivotType:Pivot) -> [Element] {
        return divide(self,pivotType)
    }
    
    func divide(_ list:[Element],_ pivotType:Pivot) -> [Element] {
        if list.count < 2 { return list }
        var newList:[Element] = list
        let pivotIndex:Int = setPivotIndexByType(pivotType, list: &newList)
        let pivot = newList[pivotIndex]
        let left = newList.filter { $0 < pivot }
        let right = newList.filter { $0 > pivot}
        return merge(divide(left,pivotType),divide(right,pivotType),pivot:pivot)
    }
    
    func merge(_ left:[Element],_ right:[Element],pivot:Int) -> [Element] {
        return left + [pivot] + right
    }
    
    func setPivotIndexByType(_ pivotType:Pivot,list:inout [Element]) -> Int {
        switch pivotType {
        case .first:
            return  0
        case .middle:
            return list.count/2-1
        case .last:
            return list.count-1
        case .random:
            return (0..<list.count).randomElement() ?? 0
        case .median:
            return setMedianPivot(list: &list)
        }
    }
    
     func setMedianPivot(list:inout [Element]) -> Int {
        let first:Int = list[0]
        let middle:Int = list[list.count/2]
        let last:Int = list[list.count-1]
        let sort:[Int] = [first,middle,last].sorted(by: <)
        list[0] = sort[0]
        list[list.count/2] = sort[1]
        list[list.count-1] = sort[2]
        return list.count/2
    }
}

numbers.sortByQuick(pivotType: .random)
