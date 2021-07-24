import { inspect } from '@xstate/inspect'
import { createMachine, interpret } from 'xstate'

inspect iframe: false

let toggleMachine = createMachine
	id: 'toggle'
	initial: 'off'
	states: 
		off:
			on:
				TOGGLE: 'on'
		on:
			on:
				TOGGLE: 'off'

let toggleService = interpret toggleMachine, {devTools: true}
toggleService.start()


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