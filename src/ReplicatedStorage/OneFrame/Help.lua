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
	GetComponents: (self: any) -> ()
}

export type Framework = {
	Component: Component,
	StartServer: (Instance: Instance, ignorePrint: any, ...any) -> boolean,
	StartClient: (Instance: Instance, ignorePrint: any, ...any) -> boolean,
}

return module