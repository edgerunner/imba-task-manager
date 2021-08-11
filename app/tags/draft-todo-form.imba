export tag DraftTodoForm
	attr todo

	prop title = ""

	def mount
		console.log todo

	def update-title
		todo.send
			type: "UPDATE"
			field: "title"
			value: title

	def submit-todo
		todo.send "SUBMIT"

	<self>
		<input @input=update-title bind=title >
		<button @click=submit-todo >
			"🆕"