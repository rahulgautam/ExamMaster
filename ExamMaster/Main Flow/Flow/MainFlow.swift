//
//  MainFlow.swift
//  ExamMaster
//
//  Created by aleksey on 27.02.16.
//  Copyright © 2016 aleksey chernish. All rights reserved.
//

import Foundation
import ModelsTreeKit

extension BubbleNotification {
  
  enum MainFlow: String, BubbleNotificationName {
    
    static var domain = "MainFlow"
    case ShowSideMenu = "ShowSideMenu"
    
  }
  
}

class MainFlow: Model {
  
  let showSideMenuSignal = Pipe<Void>()
  
  required init(parent: Model?) {
    super.init(parent: parent)
    
    register(for: BubbleNotification.MainFlow.ShowSideMenu)
    register(for: AppEvent.StartExam)
  }
  
  override func handle(globalEvent: GlobalEvent) {
    switch globalEvent.name {
    case AppEvent.StartExam:
      let flowModel = ExamCreationFlow(parent: self)
      
      let completion = { [weak self, weak flowModel] (completed: Bool) -> Void in
        guard let _self = self, _flowModel = flowModel else { return }
        _self.wantsRemoveChildSignal.sendNext(_flowModel)
      }
      
      flowModel.completionSignal.subscribeCompleted(completion).ownedBy(self)
      flowModel.cancelSignal.subscribeCompleted(completion).ownedBy(self)
      
      pushChildSignal.sendNext(flowModel)
    default:
      break
    }
  }
  
  func pushInitialChildren() {
    pushChildSignal.sendNext(DashboardModel(parent: self))
    pushChildSignal.sendNext(SideMenuModel(parent: self))
  }
  
  override func handle(bubble: BubbleNotification, sender: Model) {
    guard bubble.domain == BubbleNotification.MainFlow.domain else { return }
    
    switch bubble.name {
    case BubbleNotification.MainFlow.ShowSideMenu:
      showSideMenuSignal.sendNext()
    default:
      break
    }
  }
  
}