import './draft-todo-form'

tag todo
	prop todo

	prop emoji = {
		SUBMIT: '🆕'
		START: '▶️'
		PAUSE: '⏸'
		RESUME: '⏯'
		FINISH: '✅'
		DROP: '🚮'	
	}

	def mount
		this.todo.onTransition do imba.commit!

	def send event, payload
		this.todo.send event, payload

	
	<self .{this.todo.state.toStrings().join(" ")}>
		if this.todo.state.toStrings()[0] == 'draft'
			<draft-todo-form todo=this.todo>
		else
			<span> "{this.todo.state.context.title} "
		for event of this.todo.state.nextEvents
			continue unless emoji[event]  
			<button key=event @click=send(event)> emoji[event]