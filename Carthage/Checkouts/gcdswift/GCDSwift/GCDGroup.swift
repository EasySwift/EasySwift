import Foundation

open class GCDGroup {
 /**
  *  Returns the underlying dispatch group object.
  *
  *  - returns: The dispatch group object.
  */
  open let dispatchGroup: DispatchGroup
  
  // MARK: Lifecycle
  
 /**
  *  Initializes a new group.
  *
  *  - returns: The initialized instance.
  *  - SeeAlso: dispatch_group_create()
  */
  public convenience init() {
    self.init(dispatchGroup: DispatchGroup())
  }
  
 /**
  *  The GCDGroup designated initializer.
  *
  *  - parameter dispatchGroup: A dispatch_group_t object.
  *  - returns: The initialized instance.
  */
  public init(dispatchGroup: DispatchGroup) {
    self.dispatchGroup = dispatchGroup
  }
  
  // MARK: Public methods
  
 /**
  *  Explicitly indicates that a block has entered the group.
  *
  *  - SeeAlso: dispatch_group_enter()
  */
  open func enter() {
    return self.dispatchGroup.enter()
  }

 /**
  *  Explicitly indicates that a block in the group has completed.
  *
  *  - SeeAlso: dispatch_group_leave()
  */
  open func leave() {
    return self.dispatchGroup.leave()
  }

 /**
  *  Waits forever for the previously submitted blocks in the group to complete.
  *
  *  - SeeAlso: dispatch_group_wait()
  */
  open func wait() {
    self.dispatchGroup.wait(timeout: DispatchTime.distantFuture)
  }
  
/**
  *  Waits for the previously submitted blocks in the group to complete.
  *
  *  - parameter seconds: The time to wait in seconds.
  *  - returns: `true` if all blocks completed, `false` if the timeout occurred.
  *  - SeeAlso: dispatch_group_wait()
  */
  open func wait(_ seconds: Double) -> Bool {
    let time = DispatchTime.now() + Double(Int64(seconds * Double(GCDConstants.NanosecondsPerSecond))) / Double(NSEC_PER_SEC)
    
    return self.dispatchGroup.wait(timeout: time) == DispatchTimeoutResult.success
  }
}
