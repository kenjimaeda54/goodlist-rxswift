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

	@IBOutlet weak var segmentControl: UISegmentedControl!
	
	var disposed = DisposeBag()
	//referencia
	//https://medium.com/koolicar-engineering/rxswift-behaviorrelay-over-variable-182865ce10e0
	var tasks = BehaviorRelay<[Task]>.init(value: [])
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segueAddTask" {
			let vc = segue.destination as! AddTaskViewController
			vc.taskObersavable.subscribe(onNext:{[self] task in
				  
				let priority = Priority(rawValue: self.segmentControl.selectedSegmentIndex -1)
				
				//preciso pegar o valor antigo para atualizar
				var existingTasks = tasks.value
				//depois de pegar o antigo estou adicionado
				existingTasks.append(task)
				
				//aqui estou atualizando
				tasks.accept(existingTasks)

			}).disposed(by: disposed)
			
		}
		
	}
	
	
}

