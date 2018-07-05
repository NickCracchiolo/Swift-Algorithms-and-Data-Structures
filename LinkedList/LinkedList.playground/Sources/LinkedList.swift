import Foundation

public class Node<T:Comparable> {
    var next:Node<T>?
    weak var prev:Node<T>?
    var item:T
    
    fileprivate init(item:T, nextNode:Node? = nil, prevNode:Node? = nil) {
        self.item = item
        self.next = nextNode
        self.prev = prevNode
    }
}

public struct LinkedListIndex<T:Comparable>: Comparable {
    weak var node:Node<T>?
    let tag:Int
    
    public static func ==<T>(lhs: LinkedListIndex<T>, rhs:LinkedListIndex<T>) -> Bool {
        return lhs.tag == rhs.tag
    }
    
    public static func < <T>(lhs:LinkedListIndex<T>, rhs:LinkedListIndex<T>) -> Bool {
        return lhs.tag < rhs.tag
    }
}

public class LinkedList<T:Comparable> {
    private var head:Node<T>?
    public var count:Int
    
    public var isEmpty: Bool {
        return self.head == nil
    }
    
    public var last:T? {
        guard var h = head else {
            return nil
        }
        while let next = h.next {
            h = next
        }
        return h.item
    }
    
    public init(startingItem:T? = nil) {
        if let i = startingItem {
            self.head = Node<T>(item:i)
            count = 1
        } else {
            count = 0
        }
    }
    
    /// Checks if the list has a node with that item.
    public func hasNode(withItem i:T) -> Bool {
        var temp = head
        while let t = temp {
            if (t.item == i) {
                return true
            }
            temp = t.next
        }
        return false
    }
    
    /// Adds a node to the front of the list, making it the head
    public func addFirst(item:T) {
        guard let h = head else {
            self.head = Node<T>(item:item)
            return
        }
        let newNode = Node<T>(item:item, nextNode:h)
        h.prev = newNode
        self.head = newNode
        count += 1
    }
    
    /// Adds a node to the last item in the list
    public func addLast(item:T) {
        guard var h = head else {
            self.head = Node<T>(item:item)
            return
        }
        while let next = h.next {
            h = next
        }
        let node = Node<T>(item:item, nextNode:nil, prevNode:h)
        h.next = node
        count += 1
    }
    
    public func remove(atIndex index:Index) -> Bool {
        guard let node = index.node else {
            return false
        }
        if (index.tag > count) { return false }
        count -= 1
        guard let prev = node.prev else {
            guard let next = node.next else {
                self.head = nil
                return true
            }
            next.prev = nil
            self.head = next
            return true
        }
        guard let next = node.next else {
            prev.next = nil
            return true
        }
        prev.next = next
        next.prev = prev
        return true
    }
    
    
    public func printList() {
        var temp = head
        while temp != nil {
            print("(\(temp!.item)) -> ", terminator:"")
            temp = temp!.next
        }
        print("")
    }
}

extension LinkedList: Collection {
    public typealias Index = LinkedListIndex<T>
    
    public var startIndex:Index {
        get {
            return LinkedListIndex<T>(node: head, tag: 0)
        }
    }
    
    /// Returns the index of the last element in the LinkedList. O(1)
    public var endIndex:Index {
        get {
            guard let h = head else {
                return LinkedListIndex<T>(node: nil, tag: startIndex.tag)
            }
            return LinkedListIndex<T>(node: h, tag: count)
        }
    }
    
    public subscript(position:Index) -> T {
        get {
            return position.node!.item
        }
    }
    
    public func index(after i: LinkedList<T>.Index) -> LinkedList<T>.Index {
        return LinkedListIndex<T>(node: i.node?.next, tag: i.tag + 1)
    }
}
