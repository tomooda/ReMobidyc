Class {
	#name : 'RMD2DSpaceModel',
	#superclass : 'RMDSpaceModel',
	#instVars : [
		'xStep',
		'yStep',
		'patchLength',
		'xDivisions',
		'yDivisions',
		'patchMemorySize'
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
		  patchMemorySize: patchSize;
		  yourself
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> centerXFromPatchOffset: anInteger [

	^ (self xIndexFromPatchOffset: anInteger) asFloat - 0.5 * patchLength
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> centerYFromPatchOffset: anInteger [

	^ (self yIndexFromPatchOffset: anInteger) asFloat - 0.5 * patchLength
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> centroidFromPatchOffset: anInteger do: aBlock [

	^ aBlock value: (self centerXFromPatchOffset: anInteger) value: (self centerYFromPatchOffset: anInteger)
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> dimension [

	^ RMDType area
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> directionOfPatchOffset: anInteger fromIndividual: anotherInteger definition: aRMDAnimatDefinitionNode memory: aRMDMemory [

	| x y |
	x := (self centerXFromPatchOffset: anInteger)
	     - (aRMDMemory at: anotherInteger + (aRMDAnimatDefinitionNode offsetAt: 'x' ifAbsent: [ ])).
	y := (self centerYFromPatchOffset: anInteger)
	     - (aRMDMemory at: anotherInteger + (aRMDAnimatDefinitionNode offsetAt: 'y' ifAbsent: [ ])).
	^ (x isZero and: [ y isZero ])
		  ifTrue: [ nil ]
		  ifFalse: [ (x @ y) theta ]
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> east [

	^ patchLength * xDivisions
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> eastOfPatchOffset: anInteger do: aBlock [

	(self xIndexFromPatchOffset: anInteger) < xDivisions ifTrue: [ aBlock value: anInteger + xStep ]
]

{ #category : 'enumerating-geometry' }
RMD2DSpaceModel >> fromIndividual: anInteger definition: aRMDAnimatDefinitionNode memory: aRMDMemory withinRadius: aNumber patchOffsetsDo: aBlock [

	| x y d2 |
	x := aRMDMemory at: anInteger + (aRMDAnimatDefinitionNode offsetAt: 'x' ifAbsent: [ ]).
	y := aRMDMemory at: anInteger + (aRMDAnimatDefinitionNode offsetAt: 'y' ifAbsent: [ ]).
	d2 := aNumber squared.
	((self xIndexFromX: x - aNumber) max: 1) to: ((self xIndexFromX: x + aNumber) min: xDivisions) do: [ :xIndex |
			| x1 x2 dx dy |
			x1 := xIndex * patchLength.
			x2 := x1 - patchLength.
			dx := (x1 - x) abs min: (x2 - x) abs.
			dy := (d2 - dx squared) sqrt.
			((self yIndexFromY: y - dy) max: 1) to: ((self yIndexFromY: y + dy) min: yDivisions) do: [ :yIndex |
			aBlock value: (self patchOffsetFromXIndex: xIndex yIndex: yIndex) ] ]
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> geometryFromOffset: anInteger [

	^ Rectangle center: (self centerXFromPatchOffset: anInteger) @ (self centerYFromPatchOffset: anInteger) extent: patchLength @ patchLength
]

{ #category : 'initialization' }
RMD2DSpaceModel >> initialize [

	super initialize.
	xDivisions := 1.
	yDivisions := 1.
	patchMemorySize := 1.
	xStep := 1.
	yStep := 1.
	patchLength := 1.0
]

{ #category : 'testing' }
RMD2DSpaceModel >> is2dSpace [

	^ true
]

{ #category : 'enumerating-structure' }
RMD2DSpaceModel >> neighborsFromPatchOffset: anInteger patchOffsetsAndVectorsDo: aBlock [

	self eastOfPatchOffset: anInteger do: [ :east |
			aBlock value: east value: {
					patchLength.
					0.0 } ].
	self northOfPatchOffset: anInteger do: [ :north |
			aBlock value: north value: {
					0.0.
					patchLength } ].
	self westOfPatchOffset: anInteger do: [ :west |
			aBlock value: west value: {
					patchLength negated.
					0.0 } ].
	self southOfPatchOffset: anInteger do: [ :south |
			aBlock value: south value: {
					0.0.
					patchLength negated } ]
]

{ #category : 'enumerating-structure' }
RMD2DSpaceModel >> neighborsFromPatchOffset: anInteger patchOffsetsDo: aBlock [

	self eastOfPatchOffset: anInteger do: aBlock.
	self northOfPatchOffset: anInteger do: aBlock.
	self eastOfPatchOffset: anInteger do: aBlock.
	self northOfPatchOffset: anInteger do: aBlock
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> north [

	^ patchLength * yDivisions
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> northOfPatchOffset: anInteger do: aBlock [

	(self yIndexFromPatchOffset: anInteger) < yDivisions ifTrue: [ aBlock value: anInteger + yStep ]
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> numberOfPatches [

	^ xDivisions * yDivisions
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> patchInfoFromOffset: anInteger do: aBlock [

	aBlock value: 'center x' value: (self centerXFromPatchOffset: anInteger).
	aBlock value: 'center y' value: (self centerYFromPatchOffset: anInteger)
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

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> patchMemorySize [

	^ patchMemorySize
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> patchMemorySize: aNumber [

	patchMemorySize := aNumber max: 1.
	self updateMemorySteps
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> patchOffsetAtIndividual: anInteger definition: aRMDAgentDefinitionNode memory: aRMDMemory [

	| x y |
	x := aRMDMemory at: anInteger + (aRMDAgentDefinitionNode
			      offsetAt: 'x'
			      ifAbsent: [ RMDUndefinedAttributeError signal: (RMDAttributeVariableNode identifier: 'x' agent: nil) ]).
	y := aRMDMemory at: anInteger + (aRMDAgentDefinitionNode
			      offsetAt: 'y'
			      ifAbsent: [ RMDUndefinedAttributeError signal: (RMDAttributeVariableNode identifier: 'y' agent: nil) ]).
	^ self patchOffsetFromX: x y: y
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> patchOffsetFromX: aNumber y: anotherNumber [

	^ (aNumber // patchLength min: xDivisions - 1 max: 0) * xStep
	  + ((anotherNumber // patchLength min: yDivisions - 1 max: 0) * yStep)
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> patchOffsetFromXIndex: anInteger yIndex: anotherInteger [

	^ (anInteger min: xDivisions max: 1) - 1 * xStep + ((anotherInteger min: yDivisions max: 1) - 1 * yStep)
]

{ #category : 'enumerating-geometry' }
RMD2DSpaceModel >> patchOffsetsAndCentroidsDo: aBlock [

	self patchOffsetsDo: [ :offset |
		aBlock value: offset value: (self centerXFromPatchOffset: offset) value: (self centerYFromPatchOffset: offset) ]
]

{ #category : 'enumerating-memory' }
RMD2DSpaceModel >> patchOffsetsDo: aBlock [

	0 to: self totalMemorySize - 1 by: patchMemorySize do: aBlock
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> patchSize [

	^ patchLength squared
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> south [

	^ 0.0
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> southOfPatchOffset: anInteger do: aBlock [

	(self yIndexFromPatchOffset: anInteger) > 1 ifTrue: [ aBlock value: anInteger - yStep ]
]

{ #category : 'accessing-memory' }
RMD2DSpaceModel >> totalMemorySize [

	^ xDivisions * yDivisions * patchMemorySize
]

{ #category : 'updating' }
RMD2DSpaceModel >> updateMemorySteps [

	xStep := patchMemorySize.
	yStep := xStep * xDivisions
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> west [

	^ 0.0
]

{ #category : 'accessing-structure' }
RMD2DSpaceModel >> westOfPatchOffset: anInteger do: aBlock [

	(self xIndexFromPatchOffset: anInteger) > 1 ifTrue: [ aBlock value: anInteger - xStep ]
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
RMD2DSpaceModel >> xIndexFromPatchOffset: anInteger [

	^ anInteger // patchMemorySize \\ xDivisions + 1 min: xDivisions max: 1
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
RMD2DSpaceModel >> yIndexFromPatchOffset: anInteger [

	^ anInteger // yStep + 1 min: yDivisions max: 1
]

{ #category : 'accessing-geometry' }
RMD2DSpaceModel >> yIndexFromY: aNumber [

	^ aNumber // patchLength + 1
]
