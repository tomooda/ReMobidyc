Class {
	#name : 'RMD2dVisualizer',
	#superclass : 'RMDVisualizer',
	#instVars : [
		'worldExtent',
		'offset',
		'scale'
	],
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'instance creation' }
RMD2dVisualizer class >> extent: aPoint interpreter: aRMDInterpreter [

	^ self new
		  extent: aPoint;
		  interpreter: aRMDInterpreter;
		  yourself
]

{ #category : 'instance creation' }
RMD2dVisualizer class >> sugarScape [
	^ (self extent: 500 @ 500)
		addBackgroundRendererColor: Color brown;
		addPatchRendererColor: Color green
			alpha: 'here''s grass' asRMDExpression
			between: '0[kcal]' asRMDExpression
			and: '1000000[kcal]' asRMDExpression;
		addAnimatDotRenderer: 'Goat' diameter: 7 color: Color yellow;
		yourself
]

{ #category : 'drawing' }
RMD2dVisualizer >> drawImage: aForm forIndividual: anInteger definition: aRMDAnimatDefinitionNode [

	| position |
	position := self positionOfIndividual: anInteger definition: aRMDAnimatDefinitionNode.
	canvas translucentImage: aForm at: (self transform: position)
]

{ #category : 'drawing' }
RMD2dVisualizer >> drawPatch: anInteger color: aColor [

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
RMD2dVisualizer >> drawPatchGridWidth: aNumber color: aColor [

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
RMD2dVisualizer >> drawPolygon: aCollectionOfPoint color: aColor forIndividual: anInteger definition: aRMDAnimatDefinitionNode [

	| point |
	point := self transform: (self positionOfIndividual: anInteger definition: aRMDAnimatDefinitionNode).
	canvas
		drawPolygon: (aCollectionOfPoint collect: [ :p | point + p ])
		color: aColor
		borderWidth: 0
		borderColor: aColor
]

{ #category : 'drawing' }
RMD2dVisualizer >> drawRectangleExtent: aNumberOrPoint color: aColor forIndividual: anInteger definition: aRMDAnimatDefinitionNode [

	| point |
	point := self transform: (self positionOfIndividual: anInteger definition: aRMDAnimatDefinitionNode).
	canvas fillRectangle: (Rectangle center: point extent: aNumberOrPoint asPoint) color: aColor
]

{ #category : 'drawing' }
RMD2dVisualizer >> drawWorldColor: aColor [

	canvas fillRectangle: ((self transform: 0.0 @ worldExtent y) corner: (self transform: worldExtent x @ 0.0)) color: aColor
]

{ #category : 'accessing' }
RMD2dVisualizer >> interpreter: aRMDInterpreter [

	super interpreter: aRMDInterpreter.
	worldExtent := aRMDInterpreter geometryOfWorld extent.
	scale := formExtent x asFloat / worldExtent x min: formExtent y asFloat / worldExtent y.
	offset := formExtent x - (worldExtent x * scale) / 2.0 @ (formExtent y - (formExtent y - (worldExtent y * scale) / 2.0)).
	renderers do: [ :renderer | renderer initializeWith: aRMDInterpreter ]
]

{ #category : 'accessing' }
RMD2dVisualizer >> positionOfIndividual: anInteger definition: aRMDAnimatDefinitionNode [

	| x y |
	x := interpreter readAttribute: 'x' individual: anInteger definition: aRMDAnimatDefinitionNode.
	y := interpreter readAttribute: 'y' individual: anInteger definition: aRMDAnimatDefinitionNode.
	^ x @ y
]

{ #category : 'accessing' }
RMD2dVisualizer >> positionOfPatch: anInteger [

	| patchOffset x y |
	patchOffset := anInteger - interpreter memory patch.
	x := interpreter spaceModel centerXFromPatchOffset: patchOffset.
	y := interpreter spaceModel centerYFromPatchOffset: patchOffset.
	^ x @ y
]

{ #category : 'drawing' }
RMD2dVisualizer >> transform: aPoint [

	^ aPoint x * scale + offset x @ (aPoint y * scale negated + offset y)
]
