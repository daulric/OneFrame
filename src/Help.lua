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

type require = {
	init: (self: any, ...any?) -> (),
	preload: (self: any, ...any?) -> (),
	render: (self: any, ...any?) -> (),
	[string]: any
}

type Components = {
	state: state,
	setState: (self: any, state: setState) -> (),
	require: (self: any, module: ModuleScript) -> require,
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

type Component = {
	extend: (self: any, name: string, test: boolean?) -> Components,
	createComponent: (self: any) -> require,
	GetComponent: (self: any, name: string) -> Components,
	GetComponents: (self: any) -> (),
	GetRegisteredSignal: (self: any, handler: (name: string, class: {[any]: any}) -> nil) -> nil
}

export type Framework = {
	Component: Component,
	Start: (Folder: Instance | start, ignorePrint: any, ...any) -> boolean,
}

return module