local module = {}

type ComponentParams = {
	Cleanup: Cleanup,
	Event: Event,
	state: state,
	setState: (self: any, state: setState) -> (),
	[string]: any
}

type start = {[string]: any}
type state = {[string]: any}
type setState = (state: state?) -> {[string]: any} | {[string]: any}

export type Component = {
	state: state,
	setState: (self: any, state: setState) -> (),
	init: (self: ComponentParams, ...any?) -> (),
	preload: (self: ComponentParams, ...any?) -> (),
	render: (self: ComponentParams, ...any?) -> (),
	closing: (self: ComponentParams, ...any?) -> (),
	[string]: any
}

type Cleanup = {
	Connect: (self: any, connection: RBXScriptSignal, callback: (...any) -> ()) -> RBXScriptConnection,
	Clean: (self: any) -> boolean,
	Add: (self: any, object: any) -> Instance,
	Remove: (self: any, object: any) -> ()
}

type Event = {
	Listen: (self: any, id: string, callback: (...any) -> ...any) -> (),
	Send: (id: string) -> {
		Server: (self: any, ...any) -> (),
		Client: (self: any, player: Player, ...any) -> (),
		AllClients: (self: any, ...any) -> (),
		Cross: (self: any, ...any) -> ()
	},
	Get: (id: string) -> {
		Server: (self: any, ...any) -> ...any,
		Client: (self: any, player: Player, ...any) -> ...any,
		Cross: (self: any, ...any) -> ...any
	},
}

type ComponentFunc = {
	extend: (self: any, name: string, values: {[any]: any}) -> Component,
	GetComponent: (self: any, name: string) -> Component,
	GetComponents: (self: any) -> (),
	GetRegisteredSignal: (self: any, handler: (name: string, class: {[any]: any}) -> nil) -> nil
}

return module