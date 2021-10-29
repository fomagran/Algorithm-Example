import Foundation

//0부터 1023까지 오름차순 정렬된 배열을 섞습니다.
var numbers = (0...1023).map{$0}.shuffled()
//비교 카운트를 해줄 변수
var comparisonCount:Int = 0

extension Array where Element == Int {
    
    mutating func sortByInsertion(_ startIndex:Int?) -> [Int] {
        //비교를 진행할 기준 인덱스를 정해줍니다,
        let start = startIndex == nil ? 1 : startIndex!
        //만약 기준 인덱스가 list의 갯수만큼 왔다면 정렬이 모두 된 것이므로 list 자체를 return 해줍니다.
        if start == self.count { return self }
        //기준 인덱스의 값을 저장해주고 삭제합니다.
        let current = self.remove(at: start)
        var index = 0
        //기준 인덱스부터 0까지 차례로 앞에 값이랑 비교해주며 더 같거나 작은 값이 나올 때까지 진행합니다.
        for i in stride(from: start-1, through: 0, by:-1) {
            //비교 카운트를 +1 해줍니다.
            comparisonCount += 1
            if current >= self[i] {
                index = i+1
                break
            }
        }
        //같거나 작은 값이 나온 index에 기준 인덱스의 값을 넣어줍니다.
        self.insert(current, at:index)
        //기준 인덱스를 +1 해주고 재귀해줍니다.
        return sortByInsertion(start+1)
    }
}

let startTime = CFAbsoluteTimeGetCurrent()
numbers.sortByInsertion(nil)
let processTime = CFAbsoluteTimeGetCurrent() - startTime
print("걸린 시간 = \(processTime), 비교 횟수 = \(comparisonCount) ")
