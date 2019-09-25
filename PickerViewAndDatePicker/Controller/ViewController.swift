//
//  ViewController.swift
//  PickerViewAndDatePicker
//
//  Created by yasmeen on 9/25/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate{

    
    var DataArray = [MyData]()
    var selectedName : String?
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var DateTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        dismisspicker()
        createDatePicker()
        dismissDatePicker()
        API.GetData(lang_id: "1", apiToken: "F5vP0e2x18r3FPa7OvmWgjJ5vJSzGztj3vRJ8F79kmOATsmNt7hovH4Xer5biIJPB5H9UVyzFmR5toc1"){(error : Error?, success : Bool? , data:[MyData]?) in
            if success! {
                print("success")
                self.DataArray = data!
                print(self.DataArray)
            }else{
                print("failed")
            }
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataArray[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedName = DataArray[row].name
        NameTextField.text = selectedName
    }
    
    func createPickerView(){
        let pickerview = UIPickerView()
        pickerview.delegate = self
        NameTextField.inputView = pickerview
    }
    @objc func dismisspicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismiskeyboard))
        toolbar.setItems([doneBtn], animated: false)
        toolbar.isUserInteractionEnabled = true
        NameTextField.inputAccessoryView = toolbar
    }
    @objc func dismiskeyboard(){
        view.endEditing(true)
    }
    func createDatePicker(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(self.datepickerViewCanged(sender:)), for: UIControlEvents.valueChanged)
        DateTextField.inputView = datePicker
    }
    @objc func datepickerViewCanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        DateTextField.text = formatter.string(from: sender.date)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func dismissDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismiskeyboard))
        toolbar.setItems([doneBtn], animated: false)
        toolbar.isUserInteractionEnabled = true
        DateTextField.inputAccessoryView = toolbar
        
    }

}

