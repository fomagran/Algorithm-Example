import Foundation

var numbers:[Int] = (0...1024).map{$0}.shuffled()
var comparisonCount:Int = 0

extension Array where Element == Int{
    //피봇의 타입을 정할 enum
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
    
    //피봇을 기준으로 분할해줄 메서드
    func divide(_ list:[Element],_ pivotType:Pivot) -> [Element] {
        //만약 list의 갯수가 1개 이하라면 list를 return 해줍니다.
        if list.count < 2 { return list }
        //새로운 list
        var newList:[Element] = list
        //pivot의 index를 pivot타입에 따라 설정해줍니다.
        let pivotIndex:Int = setPivotIndexByType(pivotType, list: &newList)
        //pivot값
        let pivot = newList[pivotIndex]
        //pivot보다 더 작은 값을 담을 배열
        var left:[Element] = []
        //pivot보다 더 큰 값을 담을 배열
        var right:[Element] = []
        for element in newList {
            //비교 카운트를 +1 해줍니다.
            comparisonCount += 1
            if element < pivot {
                left.append(element)
            }else if element > pivot {
                right.append(element)
            }
        }
        //왼쪽과 오른쪽의 분할을 재귀해주고 합쳐줍니다.
        return merge(divide(left,pivotType),divide(right,pivotType),pivot:pivot)
    }
    
    //list를 합쳐줄 메서드
    func merge(_ left:[Element],_ right:[Element],pivot:Int) -> [Element] {
        //왼쪽의 배열과 피봇 그리고 오른쪽 배열을 합쳐줍니다.
        return left + [pivot] + right
    }
    
    //피봇 타입에 따라 인덱스를 설정해줄 메서드
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
    
    //median으로 pivot을 고른다면
     func setMedianPivot(list:inout [Element]) -> Int {
         //첫 번째 값
        let first:Int = list[0]
         //중간값
        let middle:Int = list[list.count/2]
        //마지막 값
        let last:Int = list[list.count-1]
        //위 3개의 값을 정렬
        let sort:[Int] = [first,middle,last].sorted(by: <)
        //정렬해준 값대로 list를 설정
        list[0] = sort[0]
        list[list.count/2] = sort[1]
        list[list.count-1] = sort[2]
        //중간값을 반환
        return list.count/2
    }
}

let startTime = CFAbsoluteTimeGetCurrent()
numbers.sortByQuick(pivotType: .median)
let processTime = CFAbsoluteTimeGetCurrent() - startTime
print("걸린 시간 = \(processTime), 비교 횟수 = \(comparisonCount) ")
