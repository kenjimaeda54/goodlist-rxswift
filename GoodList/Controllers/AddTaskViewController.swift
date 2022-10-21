//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by kenjimaeda on 21/10/22.
//

import UIKit

class AddTaskViewController: UIViewController {
	
	
	@IBOutlet weak var textfieldTask: UITextField!
	@IBOutlet weak var segmentPriority: UISegmentedControl!
	var task: Task?
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func handleSaveTask(_ sender: UIBarButtonItem) {
		guard let priority = Priority(rawValue: segmentPriority.selectedSegmentIndex),let taskField = textfieldTask.text else {return }
		task = Task(title: taskField, priority: priority)
		
	}
	
	
	/*
	 // MARK: - Navigation
	 
	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destination.
	 // Pass the selected object to the new view controller.
	 }
	 */
	
}
