Class {
	#name : 'RMDVisualizer',
	#superclass : 'Object',
	#instVars : [
		'formExtent',
		'worldExtent',
		'scale',
		'renderers',
		'formToWrite',
		'formToRead',
		'offset',
		'canvas'
	],
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'instance creation' }
RMDVisualizer class >> extent: aPoint [
	^ self new
		extent: aPoint;
		yourself
]

{ #category : 'instance creation' }
RMDVisualizer class >> sugarScape [
	^ (self extent: 500 @ 500)
		addBackgroundRendererColor: Color brown;
		addPatchRendererColor: Color green
			alpha: 'here''s grass' asRMDExpression
			between: '0[kcal]' asRMDExpression
			and: '1000000[kcal]' asRMDExpression;
		addAnimatDotRenderer: 'Goat' diameter: 7 color: Color yellow;
		yourself
]

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

{ #category : 'drawing' }
RMDVisualizer >> drawImage: aForm at: aPoint [

	canvas translucentImage: aForm at: (self transform: aPoint)
]

{ #category : 'drawing' }
RMDVisualizer >> drawLine: aPoint to: anotherPoint width: aNumber color: aColor [

	canvas
		line: (self transform: aPoint)
		to: (self transform: anotherPoint)
		width: aNumber
		color: aColor
]

{ #category : 'drawing' }
RMDVisualizer >> drawPolygon: aCollectionOfPoint color: aColor [

	canvas
		drawPolygon: (aCollectionOfPoint collect: [ :point | self transform: point ])
		color: aColor
		borderWidth: 0
		borderColor: aColor
]

{ #category : 'drawing' }
RMDVisualizer >> drawRectangle: aRectangle color: aColor [

	canvas
		fillRectangle: (Rectangle point: (self transform: aRectangle origin) point: (self transform: aRectangle corner))
		color: aColor
]

{ #category : 'drawing' }
RMDVisualizer >> drawRectangleAt: aPoint extent: aNumberOrPoint color: aColor [

	canvas fillRectangle: (Rectangle center: (self transform: aPoint) extent: aNumberOrPoint asPoint) color: aColor
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

{ #category : 'private' }
RMDVisualizer >> formToWrite [
	^ formToWrite
]

{ #category : 'initialization' }
RMDVisualizer >> initialize [
	super initialize.
	renderers := OrderedCollection new
]

{ #category : 'initialization' }
RMDVisualizer >> initializeWith: aRMDInterpreter [

	worldExtent := aRMDInterpreter geometryOfWorld extent.
	scale := formExtent x asFloat / worldExtent x min: formExtent y asFloat / worldExtent y.
	offset := formExtent x - (worldExtent x * scale) / 2.0 @ (formExtent y - (formExtent y - (worldExtent y * scale) / 2.0)).
	renderers do: [ :renderer | renderer initializeWith: aRMDInterpreter ]
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

{ #category : 'drawing' }
RMDVisualizer >> transform: aPoint [

	^ aPoint x * scale + offset x @ (aPoint y * scale negated + offset y)
]

{ #category : 'visualizing' }
RMDVisualizer >> visualize: aRMDInterpreter [

	canvas fillColor: Color white.
	renderers do: [ :renderer | renderer renderOn: self with: aRMDInterpreter ].
	self swapForms.
	^ formToRead
]

{ #category : 'accessing' }
RMDVisualizer >> worldExtent [

	^ worldExtent
]
