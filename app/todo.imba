import { createMachine } from 'xstate'

let machine = createMachine
	id: "todo"
	initial: "active"
	states:
		active:
			initial: "pending"
			states:
				pending: 
					on: {START: "running"}
				running: 
					on: 
						COMPLETE: "#todo.inactive.completed"
						PAUSE: "paused"
				paused: 
					on: {CONTINUE: "running"}
				stalled: 
					on: {CONTINUE: "running"}
				previous:
					type: "history"
			on:
				CANCEL: "inactive.cancelled"
				TRASH: "inactive.trashed"
				STALL: ".stalled"

		inactive:
			initial: "cancelled"
			states:
				cancelled: { type: "final" }
				completed: { type: "final" }
				trashed: { type: "final" }
			on: { REVERT: "active.previous" }
 

export default machine