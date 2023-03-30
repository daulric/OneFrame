local module = {}

type Execute = {
	preload: (self: any, ...any) -> (),
	render: (self: any, ...any) -> (),
	[any]: any
}

type Component = {
	serve: (self: any, name: any) -> Execute,
	test: (self: any, name: any) -> Execute,
	GetComponent: (self: any, name: string) -> Execute,
	GetComponents: (self: any) -> (),
	GetRegisteredSignal: (self: any, handler: (name: string, class: {[any]: any}) -> nil) -> nil
}

export type Framework = {
	Component: Component,
	Start: (Instance: Instance, ignorePrint: any, ...any) -> boolean,
}

return module