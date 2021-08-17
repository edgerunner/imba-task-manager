import { createMachine, assign } from 'xstate'

export default createMachine
	id: "todo"
	initial: "draft"
	context:
		title: ""

	states:
		draft:
			on:
				SUBMIT: 
					target: "pending"
					cond: "hasTitle"
				UPDATE:
					actions: "updateField"
						
		pending:
			on:
				START: "ongoing"
		ongoing:
			on:
				PAUSE: "paused"
				FINISH: "done"
		paused:
			on:
				RESUME: "ongoing"
		done:
			type: "final"
		dropped: 
			type: "final"

	on: { DROP: ".dropped" }
	,
	{
		guards:
			hasTitle: do(ctx) ctx.title.length > 3
	}
