import { createMachine, assign } from 'xstate'

export default createMachine
	id: "todo"
	initial: "draft"
	context:
		title: ""

	states:
		draft:
			initial: "invalid"
			states:
				invalid:
					always:
						cond: "hasTitle"
						target: "valid"
				valid:
					on:
						SUBMIT: "#todo.pending"
					always:
						cond: "noTitle"
						target: "invalid"
			on:
				UPDATE:
					actions:
						"updateField"

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
			noTitle: do(ctx) ctx.title.length <= 3
		actions:
			updateField: assign do(ctx,evt) [evt["field"]]: evt["value"]
	}
