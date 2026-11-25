Class {
	#name : 'RMDVisualizer',
	#superclass : 'Object',
	#instVars : [
		'formExtent',
		'renderers',
		'formToWrite',
		'formToRead',
		'canvas',
		'interpreter'
	],
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'adding-removing' }
RMDVisualizer >> addAnimatDotRenderer: aString diameter: aNumber color: aColor [

	^ self addRenderer:
		  (RMDAnimatDotRenderer on: aString shapeSize: aNumber color: aColor)
]

{ #category : 'adding-removing' }
RMDVisualizer >> addBackgroundRendererColor: aColor [
	^ self addRendererFirst: (RMDBackgroundColorRenderer color: aColor)
]

{ #category : 'adding-removing' }
RMDVisualizer >> addPatchRenderer: aRMDExpressionNode color: aColor1 value: aRMDLiteralNode1 color: aColor2 value: aRMDLiteralnode2 color: aColor3 [
	^ self
		addRenderer:
			(RMDPatchColorMapRenderer
				expression: aRMDExpressionNode
				color: aColor1
				value: aRMDLiteralNode1
				color: aColor2
				value: aRMDLiteralnode2
				color: aColor3)
]

{ #category : 'adding-removing' }
RMDVisualizer >> addPatchRendererColor: aColor alpha: aRMDExpressionNode between: aNumber and: anotherNumber [
	^ self
		addRenderer:
			(RMDPatchColorAlphaRenderer
				color: aColor
				alpha: aRMDExpressionNode
				between: aNumber
				and: anotherNumber)
]

{ #category : 'adding-removing' }
RMDVisualizer >> addPatchRendererColor: aColor brightness: aRMDExpressionNode between: aNumber and: anotherNumber [
	^ self
		addRenderer:
			(RMDPatchColorBrightnessRenderer
				color: aColor
				brightness: aRMDExpressionNode
				between: aNumber
				and: anotherNumber)
]

{ #category : 'adding-removing' }
RMDVisualizer >> addRenderer: aRMDRenderer [

	renderers add: aRMDRenderer.
	^ aRMDRenderer
]

{ #category : 'adding-removing' }
RMDVisualizer >> addRendererFirst: aRMDRenderer [

	renderers addFirst: aRMDRenderer.
	^ aRMDRenderer
]

{ #category : 'accessing' }
RMDVisualizer >> extent [
	^ formExtent
]

{ #category : 'accessing' }
RMDVisualizer >> extent: aPoint [

	formExtent := aPoint.
	(formToRead isNil or: [ formToRead extent ~= aPoint ]) ifTrue: [ formToRead := Form extent: aPoint depth: 32 ].
	(formToWrite isNil or: [ formToWrite extent ~= aPoint ]) ifTrue: [
			formToWrite := Form extent: aPoint depth: 32.
			canvas := formToWrite getCanvas ]
]

{ #category : 'initialization' }
RMDVisualizer >> initialize [
	super initialize.
	renderers := OrderedCollection new
]

{ #category : 'accessing' }
RMDVisualizer >> interpreter [

	^ interpreter
]

{ #category : 'initialization' }
RMDVisualizer >> interpreter: aRMDInterpreter [

	interpreter := aRMDInterpreter
]

{ #category : 'adding-removing' }
RMDVisualizer >> removeRenderer: aRMDRenderer ifAbsent: errorBlock [
	renderers remove: aRMDRenderer ifAbsent: [ ^ errorBlock value ].
	^ aRMDRenderer
]

{ #category : 'enumerating' }
RMDVisualizer >> renderersDo: aBlock [
	renderers do: aBlock
]

{ #category : 'enumerating' }
RMDVisualizer >> renderersReverseDo: aBlock [
	renderers reverseDo: aBlock
]

{ #category : 'private' }
RMDVisualizer >> swapForms [

	| form |
	form := formToRead.
	formToRead := formToWrite.
	formToWrite := form.
	canvas := formToWrite getCanvas
]

{ #category : 'visualizing' }
RMDVisualizer >> visualize: aRMDInterpreter [

	canvas fillColor: Color white.
	renderers do: [ :renderer | renderer renderOn: self ].
	self swapForms.
	^ formToRead
]
