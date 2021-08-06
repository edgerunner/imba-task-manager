import { inspect } from '@xstate/inspect'
import { createMachine, interpret, assign, spawn, actions } from 'xstate'
import todos from './todos'

inspect iframe: false

console.log todos

let toggleMachine = createMachine
	id: 'toggle'
	initial: 'off'
	context: {todos: undefined}
	states: 
		off:
			on: {TOGGLE: 'on'}
		on:
			on: 
				TOGGLE: 'off'
			entry: assign {todos: do spawn todos, "todos"}
			exit: actions.stop do $1.todos

let toggleService = interpret toggleMachine, {devTools: true}
toggleService.start!


global css html
	ff:sans

tag app
	<self>
		<header>
			<svg[w:200px h:auto] src='./logo.svg'>
			<p> "Edit {<code> "app/client.imba"} and save to reload"
			<a href="https://imba.io"> "Learn Imba"
			<p>
				<button @click=toggleService.send('TOGGLE')> toggleService.state.value

imba.mount <app>