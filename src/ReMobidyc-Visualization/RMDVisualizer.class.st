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
		'canvas',
		'interpreter'
	],
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'instance creation' }
RMDVisualizer class >> extent: aPoint interpreter: aRMDInterpreter [

	^ self new
		  extent: aPoint;
		  interpreter: aRMDInterpreter;
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

	aRMDRenderer initializeWith: interpreter.
	renderers add: aRMDRenderer.
	^ aRMDRenderer
]

{ #category : 'adding-removing' }
RMDVisualizer >> addRendererFirst: aRMDRenderer [

	aRMDRenderer initializeWith: interpreter.
	renderers addFirst: aRMDRenderer.
	^ aRMDRenderer
]

{ #category : 'drawing' }
RMDVisualizer >> drawImage: aForm forIndividual: anInteger definition: aRMDAnimatDefinitionNode [

	| position |
	position := self positionOfIndividual: anInteger definition: aRMDAnimatDefinitionNode.
	canvas translucentImage: aForm at: (self transform: position)
]

{ #category : 'drawing' }
RMDVisualizer >> drawPatch: anInteger color: aColor [

	| position x y halfLength |
	position := self positionOfPatch: anInteger.
	x := position x.
	y := position y.
	halfLength := interpreter patchLength / 2.0.
	canvas
		fillRectangle: ((self transform: x - halfLength @ (y + halfLength)) corner: (self transform: x + halfLength @ (y - halfLength)))
		color: aColor
]

{ #category : 'drawing' }
RMDVisualizer >> drawPatchGridWidth: aNumber color: aColor [

	| xDivisions yDivisions patchLength |
	xDivisions := interpreter spaceModel xDivisions.
	yDivisions := interpreter spaceModel yDivisions.
	patchLength := interpreter patchLength.
	0 to: xDivisions do: [ :x |
			canvas
				line: (self transform: x * patchLength @ 0)
				to: (self transform: x * patchLength @ (yDivisions * patchLength))
				width: aNumber
				color: aColor ].
	0 to: yDivisions do: [ :y |
			canvas
				line: (self transform: 0 @ (y * patchLength))
				to: (self transform: xDivisions * patchLength @ (y * patchLength))
				width: aNumber
				color: aColor ]
]

{ #category : 'drawing' }
RMDVisualizer >> drawPolygon: aCollectionOfPoint color: aColor forIndividual: anInteger definition: aRMDAnimatDefinitionNode [

	| point |
	point := self transform: (self positionOfIndividual: anInteger definition: aRMDAnimatDefinitionNode).
	canvas
		drawPolygon: (aCollectionOfPoint collect: [ :p | point + p ])
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
RMDVisualizer >> drawRectangleExtent: aNumberOrPoint color: aColor forIndividual: anInteger definition: aRMDAnimatDefinitionNode [

	| point |
	point := self transform: (self positionOfIndividual: anInteger definition: aRMDAnimatDefinitionNode).
	canvas fillRectangle: (Rectangle center: point extent: aNumberOrPoint asPoint) color: aColor
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

{ #category : 'accessing' }
RMDVisualizer >> interpreter [

	^ interpreter
]

{ #category : 'initialization' }
RMDVisualizer >> interpreter: aRMDInterpreter [

	interpreter := aRMDInterpreter.
	worldExtent := aRMDInterpreter geometryOfWorld extent.
	scale := formExtent x asFloat / worldExtent x min: formExtent y asFloat / worldExtent y.
	offset := formExtent x - (worldExtent x * scale) / 2.0 @ (formExtent y - (formExtent y - (worldExtent y * scale) / 2.0)).
	renderers do: [ :renderer | renderer initializeWith: aRMDInterpreter ]
]

{ #category : 'accessing' }
RMDVisualizer >> positionOfIndividual: anInteger definition: aRMDAnimatDefinitionNode [

	| x y |
	x := interpreter readAttribute: 'x' individual: anInteger definition: aRMDAnimatDefinitionNode.
	y := interpreter readAttribute: 'y' individual: anInteger definition: aRMDAnimatDefinitionNode.
	^ x @ y
]

{ #category : 'accessing' }
RMDVisualizer >> positionOfPatch: anInteger [

	| patchOffset x y |
	patchOffset := anInteger - interpreter memory patch.
	x := interpreter spaceModel centerXFromPatchOffset: patchOffset.
	y := interpreter spaceModel centerYFromPatchOffset: patchOffset.
	^ x @ y
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
	renderers do: [ :renderer | renderer renderOn: self ].
	self swapForms.
	^ formToRead
]

{ #category : 'accessing' }
RMDVisualizer >> worldExtent [

	^ worldExtent
]
