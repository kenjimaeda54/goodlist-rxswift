//
//  ViewController.swift
//  GoodList
//
//  Created by kenjimaeda on 21/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class TaskViewController: UIViewController {

	//MARK: - IBOutlet
	@IBOutlet weak var tableViewTask: UITableView!
	@IBOutlet weak var segmentControl: UISegmentedControl!

	//MARK: - Vars
	var disposed = DisposeBag()
	//referencia
	//https://medium.com/koolicar-engineering/rxswift-behaviorrelay-over-variable-182865ce10e0
	var tasks = BehaviorRelay<[Task]>.init(value: [])
	var filteredTasks = [Task]()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//de preferencia implementar  o delegate e data source no storyborad
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segueAddTask" {
			let vc = segue.destination as! AddTaskViewController
			vc.taskObersavable.subscribe(onNext:{[self] task in
				
				//para filtrar todos
				let priority = Priority(rawValue: self.segmentControl.selectedSegmentIndex - 1)
			  
				//preciso pegar o valor antigo para atualizar
				var existingTask = tasks.value
				//depois de pegar o antigo estou adicionado
				existingTask.append(task)
				//aqui estou atualizando
				tasks.accept(existingTask)
				filterTasks(priority)
				
			}).disposed(by: disposed)
			
		}
		
	}
	
	@IBAction func handleSelectSegmentControl(_ sender: UISegmentedControl) {
			
		filterTasks(Priority(rawValue: sender.selectedSegmentIndex - 1))
	  
	}
	
	func updateList() {
			self.tableViewTask.reloadData()
	}
	
	func filterTasks(_ priority: Priority?) {
		
		if priority == nil {
			self.filteredTasks = tasks.value
			updateList()
		}else {
			
			//value que possui o valor
			//accepted e para atualizar
			self.filteredTasks =  self.tasks.value.filter {
				$0.priority == priority!
			}
			updateList()
		}
		
	}
	
	
}


extension TaskViewController: UITableViewDelegate,UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return  filteredTasks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let task = filteredTasks[indexPath.row]
		var content = cell.defaultContentConfiguration()
		content.text = task.title
		cell.contentConfiguration = content
		return cell
	}
	
	
}
