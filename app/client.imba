import { inspect } from '@xstate/inspect'
import { createMachine, interpret, assign, spawn, actions } from 'xstate'
import todo from './todo'

inspect iframe: false

let toggleMachine = createMachine
	id: 'toggle'
	initial: 'off'
	context: {todo: undefined}
	states: 
		off:
			on: {TOGGLE: 'on'}
		on:
			on: 
				TOGGLE: 'off'
				"done.invoke.todo": 'off'
			entry: assign {todo: do spawn todo, "todo"}
			exit: actions.stop do $1.todo

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