import { createMachine, assign, spawn } from 'xstate'
import todo from './todo'

const machine-spec =
	id: "todos"
	initial: "blank"
	context:
		todos: []
		summary: {}

	states:
		blank: {}
		ongoing:
			always:
				cond: "all resolved"
				target: "resolved"
		resolved: {}

	on:
		ADD:
			target: "ongoing"
			actions: "add todo"

	

const machine-config =
	guards:
		"all resolved": do({todos}) todos.every(do $1.state.done)
	
	actions:
		"add todo": 
			assign
				todos: do(ctx) ctx.todos.concat([spawn todo])

export default createMachine(machine-spec, machine-config)

