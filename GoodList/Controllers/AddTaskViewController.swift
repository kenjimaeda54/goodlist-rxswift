//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by kenjimaeda on 21/10/22.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
	
	
	@IBOutlet weak var textfieldTask: UITextField!
	@IBOutlet weak var segmentPriority: UISegmentedControl!
	
	var task: Task?
	var taskSubject = PublishSubject<Task>()
	var taskObersavable: Observable<Task> {
		return taskSubject.asObservable()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func handleSaveTask(_ sender: UIBarButtonItem) {
		guard let priority = Priority(rawValue: segmentPriority.selectedSegmentIndex),let taskField = textfieldTask.text else {return }
		task = Task(title: taskField, priority: priority)
		taskSubject.onNext(task!)
		navigationController?.popToRootViewController(animated: true)
	}

}
