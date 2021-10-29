import Foundation

var numbers:[Int] = (0...1023).map{$0}.shuffled()
var comparisonCount:Int = 0

extension Array where Element == Int{
    
    mutating func sortByMerge() -> [Element] {
        comparisonCount = 0
        return divide(self)
    }
    
    //list를 반으로 분할해주는 함수입니다.
    private func divide(_ list:[Element]) -> [Element] {
        //만약 list의 갯수가 1개 이하라면 list를 return해줍니다.
        if list.count <= 1 { return list }
        let mid:Int = list.count/2
        let left:[Element] = Array(list[0..<mid])
        let right:[Element] = Array(list[mid..<list.count])
        
        //왼쪽 list와 오른쪽 list를 재귀해주고 element가 1개만 남았을 땐 합쳐줍니다.
        return merge(divide(left), divide(right))
    }
    
    //element들을 서로 합쳐주는 함수입니다.
    private func merge(_ left:[Element],_ right:[Element]) -> [Element] {
        var l:[Element] = left
        var r:[Element] = right
        var list:[Element] = []
        
        //왼쪽과 오른쪽 모두 비어있지 않다면 반복합니다.
        while !l.isEmpty && !r.isEmpty {
            //비교 카운트를 +1 해줍니다.
            comparisonCount += 1
            //만약 왼쪽 list의 첫 번째가 오른쪽 list의 첫 번째가 더 작다면
            if l.first! < r.first! {
                //왼쪽 첫 번째 element를 새로운 list에 넣어주고 삭제합니다.
                list.append(l.removeFirst())
            //만약 오른쪽 list의 첫 번째가 왼쪽 list의 첫 번째가 더 작다면
            }else {
                //오른쪽 첫 번째 element를 새로운 list에 넣어주고 삭제합니다.
                list.append(r.removeFirst())
            }
        }
        //비교가 끝나고 왼쪽이나 오른쪽에 남은 element들을 모두 list에 추가해줍니다.
        list.append(contentsOf: l+r)
        return list
    }
}

let startTime = CFAbsoluteTimeGetCurrent()
//Sort 메서드 실행
let processTime = CFAbsoluteTimeGetCurrent() - startTime
print("걸린 시간 = \(processTime), 비교 횟수 = \(comparisonCount) ")
