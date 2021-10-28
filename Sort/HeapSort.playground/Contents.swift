import Foundation

struct MaxHeap {
    var nodes:[Int] = []
    
    //만약 초기값이 있다면 nodes에 추가해줍니다.
    init(nodes:[Int]) {
        nodes.forEach {
            insert($0)
        }
    }
    
    //자식과 부모의 index를 찾아줄 메서드들
    private func getLeftChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }
    private func getRightChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }
    private func getParentIndex(_ childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }
    
    //자식이나 부모가 있는지 여부를 확인할 메소드들
    private func hasLeftChild(_ index: Int) -> Bool {
        return getLeftChildIndex(index) < nodes.count
    }
    private func hasRightChild(_ index: Int) -> Bool {
        return getRightChildIndex(index) < nodes.count
    }
    private func hasParent(_ index: Int) -> Bool {
        return getParentIndex(index) >= 0
    }
    
    //새로운 원소를 삽입할 때 리프에서부터 히피파이를 진행할 메서드
    mutating private func heapifyUp() {
        //가장 마지막 인덱스로 세팅해줍니다.
        var index = nodes.count - 1
        //만약 부모가 있고 현재 인덱스의 값이 부모의 값보다 더 크다면
        while hasParent(index) && nodes[getParentIndex(index)] < nodes[index] {
            //비교 카운트를 +1 해줍니다.
            comparisonCount += 1
            //부모와 현재 인덱스의 값을 바꿔줍니다.
            nodes.swapAt(getParentIndex(index),index)
            //index를 부모인덱스로 바꿔줍니다.
            index = getParentIndex(index)
        }
    }
    
    //node를 삽입하는 메서드
    mutating func insert(_ node:Int) {
        //새로운 node를 추가해줍니다.
        nodes.append(node)
        //히피파이를 진행합니다.
        heapifyUp()
    }
    
    //node가 삭제되었을 때 루트부터 히피파이를 진행합니다.
    mutating private func heapifyDown() {
        //루트를 index로 설정해줍니다.
        var index = 0
        //만약 왼쪽 자식이 있다면
        while hasLeftChild(index) {
            //비교 카운트를 +1 해줍니다.
            comparisonCount += 1
            //왼쪽 자식의 인덱스
            let leftIndex:Int = getLeftChildIndex(index)
            //오른쪽 자식의 인덱스
            let rightIndex:Int = getRightChildIndex(index)
            //왼쪽 인덱스로 더 큰 자식을 설정해줍니다.
            var biggerChildIndex = leftIndex
            //만약 오른쪽 자식이 있고 오른쪽 자식이 왼쪽 자식보다 더 크다면
            if hasRightChild(index) && nodes[leftIndex] < nodes[rightIndex] {
                //더 큰 자식의 인덱스를 오른쪽 자식 인덱스로 설정해줍니다.
                biggerChildIndex = rightIndex
            }
            
            //만약 현재 index의 값이 더 큰 자식의 인덱스의 값보다 크다면
            if nodes[index] > nodes[biggerChildIndex] {
                //더 이상 비교할 필요가 없으므로 break해줍니다.
                break
            //만약 현재 index의 값이 더 큰 자식의 인덱스의 값보다 작다면
            } else {
                //자식과 현재 인덱스의 값을 바꿔줍니다.
                nodes.swapAt(index, biggerChildIndex)
            }
            //index를 자식으로 바꿔줍니다.
            index = biggerChildIndex
        }
    }
    
    //node를 삭제해줄 메서드
    mutating func remove()  {
        //만약 nodes가 비어있다면 삭제하지 않습니다.
        if nodes.isEmpty {
            return
        }
        //루트와 리프의 값으 바꿔줍니다.
        nodes.swapAt(0, nodes.count - 1)
        //리프값을 삭제해줍니다.
        nodes.removeLast()
        //히피파이를 진행합니다.
        heapifyDown()
    }
}

var numbers:[Int] = (0...1023).map{$0}.shuffled()
var comparisonCount:Int = 0

extension Array where Element == Int{
    func sortByHeap() -> [Element] {
        var heap = MaxHeap(nodes:self)
        var newList:[Int] = []
        for _ in heap.nodes {
            //heap의 첫 번째(가장 큰 값)
            if let max = heap.nodes.first {
                //가장 첫 번째로 삽입해줍니다.
                newList.insert(max, at: 0)
            }
            //힙의 가장 첫 번째 삭제
            heap.remove()
        }
        return newList
    }
}

func processTime(blockFunction: () -> ()) {
    let startTime = CFAbsoluteTimeGetCurrent()
    blockFunction()
    let processTime = CFAbsoluteTimeGetCurrent() - startTime
    print("걸린 시간 = \(processTime)")
}
 
processTime {
    numbers.sortByHeap()
}
print(comparisonCount)


