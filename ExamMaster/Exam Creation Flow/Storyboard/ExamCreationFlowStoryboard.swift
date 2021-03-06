//
//  ExamCreationFlowStoryboard.swift
//  ExamMaster
//
//  Created by aleksey on 28.02.16.
//  Copyright © 2016 aleksey chernish. All rights reserved.
//

import Foundation
import UIKit

class ExamCreationFlowStoryboard: UIStoryboard {
  
  class func optionsViewController() -> ExamOptionsPickerViewController {
    return storyboard.instantiateViewControllerWithIdentifier("Options") as! ExamOptionsPickerViewController
  }
  
  class func confirmationViewController() -> ExamCreationConfirmationViewController {
    return storyboard.instantiateViewControllerWithIdentifier("Confirmation") as! ExamCreationConfirmationViewController
  }
  
  static var storyboard: UIStoryboard {
    return UIStoryboard(name: "ExamCreationFlow", bundle: nil)
  }
  
}