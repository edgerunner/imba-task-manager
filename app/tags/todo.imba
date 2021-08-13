import './draft-todo-form'

tag todo
	prop todo

	def mount
		this.todo.onTransition do imba.commit!

	def send event, payload
		this.todo.send event, payload
	
	<self .{this.todo.state.toStrings().join(" ")}>
		this.todo.state.context.title
		switch this.todo.state.toStrings()[0]
			when 'draft'
				<draft-todo-form todo=this.todo>
			when 'pending' 
				<button @click=send("START") > '▶️'
			when 'ongoing'
				<button @click=send("PAUSE") > '⏸'
				<button @click=send("FINISH") > '✅'
			when 'paused'
				<button @click=send("RESUME") > '⏯'
			
		<button @click=send("DROP")> '🚮'

