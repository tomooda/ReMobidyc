Class {
	#name : 'RMD2DSpaceModel',
	#superclass : 'RMDSpaceModel',
	#instVars : [
		'xStep',
		'yStep',
		'patchLength',
		'patchSize',
		'xDivisions',
		'yDivisions'
	],
	#category : 'ReMobidyc-Interpreter-Space',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Space'
}

{ #category : 'instance creation' }
RMD2DSpaceModel class >> squarePatches: xDivisions by: yDivisions length: patchLength numAttributes: patchSize [

	^ self new
		  patchLength: patchLength;
		  xDivisions: xDivisions;
		  yDivisions: yDivisions;
		  patchSize: patchSize;
		  yourself
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> centerXFromOffset: anInteger [

	^ (self xIndexFromOffset: anInteger) asFloat - 0.5 * patchLength
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> centerYFromOffset: anInteger [

	^ (self yIndexFromOffset: anInteger) asFloat - 0.5 * patchLength
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> directionOfOffset: anInteger fromX: aNumber y: anotherNumber [

	| x y |
	x := (self centerXFromOffset: anInteger) - aNumber.
	y := (self centerYFromOffset: anInteger) - anotherNumber.
	^ (x isZero and: [ y isZero ])
		  ifTrue: [ nil ]
		  ifFalse: [ (x @ y) theta ]
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> east [

	^ patchLength * xDivisions
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> eastOfOffset: anInteger do: aBlock [

	(self xIndexFromOffset: anInteger) < xDivisions ifTrue: [ aBlock value: anInteger + xStep ]
]

{ #category : 'enumerating' }
RMD2DSpaceModel >> fromX: x y: y withinRadius: range offsetsDo: aBlock [

	| d2 |
	d2 := range squared.
	((self xIndexFromX: x - range) max: 1) to: ((self xIndexFromX: x + range) min: xDivisions) do: [ :xIndex |
			| x1 x2 dx dy |
			x1 := xIndex * patchLength.
			x2 := x1 - patchLength.
			dx := (x1 - x) abs min: (x2 - x) abs.
			dy := (d2 - dx squared) sqrt.
			((self yIndexFromY: y - dy) max: 1) to: ((self yIndexFromY: y + dy) min: yDivisions) do: [ :yIndex |
			aBlock value: (self offsetFromXIndex: xIndex yIndex: yIndex) ] ]
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> geometryFromOffset: anInteger [

	^ Rectangle center: (self centerXFromOffset: anInteger) @ (self centerYFromOffset: anInteger) extent: patchLength @ patchLength
]

{ #category : 'initialization' }
RMD2DSpaceModel >> initialize [

	super initialize.
	xDivisions := 1.
	yDivisions := 1.
	patchSize := 1.
	xStep := 1.
	yStep := 1.
	patchLength := 1.0
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> locationArea [

	^ patchLength squared
]

{ #category : 'enumerating' }
RMD2DSpaceModel >> neighborsFromOffset: anInteger offsetsAndVectorsDo: aBlock [

	self eastOfOffset: anInteger do: [ :east |
			aBlock value: east value: {
					patchLength.
					0.0 } ].
	self northOfOffset: anInteger do: [ :north |
			aBlock value: north value: {
					0.0.
					patchLength } ].
	self westOfOffset: anInteger do: [ :west |
			aBlock value: west value: {
					patchLength negated.
					0.0 } ].
	self southOfOffset: anInteger do: [ :south |
			aBlock value: south value: {
					0.0.
					patchLength negated } ]
]

{ #category : 'enumerating' }
RMD2DSpaceModel >> neighborsFromOffset: anInteger offsetsDo: aBlock [

	self eastOfOffset: anInteger do: aBlock.
	self northOfOffset: anInteger do: aBlock.
	self eastOfOffset: anInteger do: aBlock.
	self northOfOffset: anInteger do: aBlock
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> north [

	^ patchLength * yDivisions
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> northOfOffset: anInteger do: aBlock [

	(self yIndexFromOffset: anInteger) < yDivisions ifTrue: [ aBlock value: anInteger + yStep ]
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> offsetAtIndividual: anInteger definition: aRMDAgentDefinitionNode memory: aRMDMemory [

	| x y |
	x := aRMDMemory at: anInteger + (aRMDAgentDefinitionNode
			      offsetAt: 'x'
			      ifAbsent: [ RMDUndefinedAttributeError signal: (RMDAttributeVariableNode identifier: 'x' agent: nil) ]).
	y := aRMDMemory at: anInteger + (aRMDAgentDefinitionNode
			      offsetAt: 'y'
			      ifAbsent: [ RMDUndefinedAttributeError signal: (RMDAttributeVariableNode identifier: 'y' agent: nil) ]).
	^ self offsetFromX: x y: y
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> offsetFromX: aNumber y: anotherNumber [

	^ (aNumber // patchLength min: xDivisions - 1 max: 0) * xStep
	  + ((anotherNumber // patchLength min: yDivisions - 1 max: 0) * yStep)
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> offsetFromXIndex: anInteger yIndex: anotherInteger [

	^ (anInteger min: xDivisions max: 1) - 1 * xStep + ((anotherInteger min: yDivisions max: 1) - 1 * yStep)
]

{ #category : 'enumerating' }
RMD2DSpaceModel >> offsetsDo: aBlock [

	0 to: self totalMemorySize - 1 by: patchSize do: aBlock
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> patchInfoFromOffset: anInteger do: aBlock [

	aBlock value: 'center x' value: (self centerXFromOffset: anInteger).
	aBlock value: 'center y' value: (self centerYFromOffset: anInteger)
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> patchInfoKeysDo: aBlock [

	aBlock
		value: 'center x';
		value: 'center y'
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> patchLength [

	^ patchLength
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> patchLength: aNumber [

	patchLength := aNumber
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> patchSize [

	^ patchSize
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> patchSize: aNumber [

	patchSize := aNumber.
	self updateMemorySteps 
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> south [

	^ 0.0
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> southOfOffset: anInteger do: aBlock [

	(self yIndexFromOffset: anInteger) > 1 ifTrue: [ aBlock value: anInteger - yStep ]
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> totalMemorySize [

	^ xDivisions * yDivisions * patchSize
]

{ #category : 'updating' }
RMD2DSpaceModel >> updateMemorySteps [

	xStep := patchSize.
	yStep := xStep * xDivisions
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> west [

	^ 0.0
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> westOfOffset: anInteger do: aBlock [

	(self xIndexFromOffset: anInteger) > 1 ifTrue: [ aBlock value: anInteger - xStep ]
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> xDivisions [

	^ xDivisions
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> xDivisions: anInteger [

	xDivisions := anInteger
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> xIndexFromOffset: anInteger [

	^ anInteger // patchSize \\ xDivisions + 1 min: xDivisions max: 1
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> xIndexFromX: aNumber [

	^ aNumber // patchLength + 1
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> yDivisions [

	^ yDivisions
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> yDivisions: anInteger [

	yDivisions := anInteger
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> yIndexFromOffset: anInteger [

	^ anInteger // yStep + 1 min: yDivisions max: 1
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> yIndexFromY: aNumber [

	^ aNumber // patchLength + 1
]
