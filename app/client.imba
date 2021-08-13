import { inspect } from '@xstate/inspect'
import { interpret } from 'xstate'
import todos from './todos'
import './tags/todo'

inspect iframe: false, url: "https://stately.ai/viz?inspect"


global css html
	ff:sans

css .dropped@marker
	content: '🚮 '

css .done@marker
	content: '✅ '


tag app
	prop service = interpret todos, {devTools: true} 
	
	def setup
		service.start!
		service.onTransition do imba.commit!
		

	<self>
		<div>
			switch service.state.value
				when "blank"
					<button @click=service.send("ADD")> "Add your first todo"
				when "ongoing"
					<ul>
						for todo of service.state.context.todos
							<li>
								<todo todo=todo>
					<button @click=service.send("ADD")> "Add another todo"
				when "resolved"
					<button @click=service.send("ADD")> "Add yet another todo"
					<ul>
						for todo of service.state.context.todos
							<li .{todo.state.value}> todo.state.context.title
					
				else
					"WTF?"

imba.mount <app>