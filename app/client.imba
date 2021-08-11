import { inspect } from '@xstate/inspect'
import { interpret } from 'xstate'
import todos from './todos'
import { DraftTodoForm } from './tags/draft-todo-form'

inspect iframe: false, url: "https://stately.ai/viz"


global css html
	ff:sans

tag app
	prop service = interpret todos, {devTools: true} 
	
	def setup
		service.start!
		service.onTransition do imba.commit!
		

	<self>
		<header>
			<svg[w:200px h:auto] src='./logo.svg'>
			<p> "Edit {<code> "app/client.imba"} and save to reload"
			<a href="https://imba.io"> "Learn Imba"
		<div>
			switch service.state.value
				when "blank"
					<button @click=service.send("ADD")> "Add your first todo"
				when "ongoing"
					<ul>
						for todo of service.state.context.todos
							<li>
								<DraftTodoForm todo=todo>
					<button @click=service.send("ADD")> "Add another todo"
				when "resolved"
					<button @click=service.send("ADD")> "Add yet another todo"
				else
					"WTF?"

imba.mount <app>