# Good list
Aplicação de todo com filtros de prioridade 

## Motivação
Praticar mais RxSwfit e operadores de filtros


## Feature
- Usei o [BehaviorRelay]( https://github.com/kenjimaeda54/concepts-RxSwift-swift) para setar  variável 
- Valor da variável fica em value e para atualizar usamos o accepted
- Repara que para acessar a função filter precisei usar value
- Para atualizar primeiro instanciei o valor da variável em outra 
- Agora com o valor antigo, posso fazer um append com novos valores
- Atualizar uso a  palavra reservada accepted

```swift
  //atualizar
  
  	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segueAddTask" {
			let vc = segue.destination as! AddTaskViewController
			vc.taskObersavable.subscribe(onNext:{[self] task in
				
				//para filtrar todos
				let priority = Priority(rawValue: self.segmentControl.selectedSegmentIndex - 1)
			  
		
				var existingTask = tasks.value
				existingTask.append(task)
				tasks.accept(existingTask)
				filterTasks(priority)
				
			}).disposed(by: disposed)
			
		}
		
	}


  //filtrar
	func filterTasks(_ priority: Priority?) {
		
		if priority == nil {
			self.filteredTasks = tasks.value
			updateList()
		}else {
		 
			self.filteredTasks =  self.tasks.value.filter {
				$0.priority == priority!
			}
			updateList()
		}
		
	}

```
