export tag draft-todo-form
	prop todo

	def update-title {target}
		todo.send
			type: "UPDATE"
			field: "title"
			value: target.value

	<self>
		<input @input=update-title >