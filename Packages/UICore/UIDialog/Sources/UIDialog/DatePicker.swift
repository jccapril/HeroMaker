//
//  DatePicker.swift
//  
//
//  Created by jcc on 2023/3/3.
//

import UIKit

public class DatePicker: UIViewController {
    
    @IBOutlet weak var picker: UIDatePicker!
    
    public var defaultDate: Date?
    
    public var date: Date {
        picker.date
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "DatePicker", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: override
extension DatePicker {
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let date = defaultDate {
            picker.date = date
        }
        picker.maximumDate = Date()
    
        
    }

}
