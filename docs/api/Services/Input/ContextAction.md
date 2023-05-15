# Context Action

This is a wrapper for Roblox's Context Action Service. We created this to address the issue with mobile button. The buttons are not 100% finished but it a usable.

- Roblox's Context Action Service currently binds up to 8 actions in order for mobile buttons to work.

- We created this so you can create mobiles buttons without wrapping you head around the fact that you cant bind actions and edit buttons with Context Action Service.

- This will be removed when Roblox fixes their issue.

## BindAction
```lua
ContextAction:BindAction(name: string, func: function, touchButton: boolean, ...)
```
This create a action that binds with mobile buttons as well as keyboard, mouse and gamepad.

## Edit Image
```lua
ContextAction:EditImage(name: string, id: number)
```

This edits the image of the button.

## Edit Text
```lua
ContextAction:EditText(name: string, text: string)
```

This edits the text of the button

## Edit Property
```lua
ContextAction:EditProperty(name: string, properties)
```

This edit the properties in a table like format

## Get Button
```lua
ContextAction:GetButton(name: string) : Button
```

This returns the button associated with the name

## Unbind Action
```lua
ContextAction:UnbindAction(name)
```

This unbinds the action