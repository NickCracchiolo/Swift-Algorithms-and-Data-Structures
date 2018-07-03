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

public class LinkedList<T:Comparable> {
    private var head:Node<T>?
    
    public var last:T? {
        guard var h = head else {
            return nil
        }
        while let next = h.next {
            h = next
        }
    }
    
    public init(startingItem:T? = nil) {
        if let i = startingItem {
            self.head = Node<T>(item:i)
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
    }
    
    public func find(item:T) ->
    
    public func printList() {
        var temp = head
        while temp != nil {
            print("(\(temp!.item)) -> ", terminator:"")
            temp = temp!.next
        }
        print("")
    }
}
