export tag draft-todo-form
	prop todo

	def update-title {target}
		todo.send
			type: "UPDATE"
			field: "title"
			value: target.value

	def submit-todo
		todo.send "SUBMIT"

	<self>
		<input @input=update-title >
		<button @click=submit-todo >
			"🆕"