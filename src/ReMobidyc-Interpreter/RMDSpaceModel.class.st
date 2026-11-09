Class {
	#name : 'RMDSpaceModel',
	#superclass : 'Object',
	#instVars : [
		'xPatches',
		'yPatches',
		'patchSize',
		'xStep',
		'yStep',
		'patchLength'
	],
	#category : 'ReMobidyc-Interpreter-Core',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Core'
}

{ #category : 'accessing-geometry' }
RMDSpaceModel >> east [

	^ patchLength * xPatches
]

{ #category : 'accessing-structure' }
RMDSpaceModel >> eastOfOffset: anInteger do: aBlock [

	(self xIndexFromOffset: anInteger) < xPatches ifTrue: [ aBlock value: anInteger + xStep ]
]

{ #category : 'initialization' }
RMDSpaceModel >> initialize [

	super initialize.
	xPatches := 1.
	yPatches := 1.
	patchSize := 1.
	xStep := 1.
	yStep := 1.
	patchLength := 1.0
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> north [

	^ patchLength * yPatches
]

{ #category : 'accessing-structure' }
RMDSpaceModel >> northOfOffset: anInteger do: aBlock [

	(self yIndexFromOffset: anInteger) < yPatches ifTrue: [ aBlock value: anInteger + yStep ]
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> offsetFromX: aNumber y: anotherNumber [

	^ aNumber // patchLength * xStep + (anotherNumber // patchLength * yStep)
]

{ #category : 'accessing-memory' }
RMDSpaceModel >> offsetFromXIndex: anInteger yIndex: anotherInteger [

	^ anInteger - 1 * xStep + (anotherInteger - 1 * yStep)
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> patchArea [

	^ patchLength squared
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> patchLength [

	^ patchLength
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> patchLength: aNumber [

	patchLength := aNumber
]

{ #category : 'accessing-memory' }
RMDSpaceModel >> patchSize [

	^ patchSize
]

{ #category : 'accessing-memory' }
RMDSpaceModel >> patchSize: aNumber [

	patchSize := aNumber.
	self updateMemorySteps 
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> south [

	^ 0.0
]

{ #category : 'accessing-structure' }
RMDSpaceModel >> southOfOffset: anInteger do: aBlock [

	(self yIndexFromOffset: anInteger) > 1 ifTrue: [ aBlock value: anInteger - yStep ]
]

{ #category : 'updating' }
RMDSpaceModel >> updateMemorySteps [

	xStep := patchSize.
	yStep := xStep * xPatches
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> west [

	^ 0.0
]

{ #category : 'accessing-structure' }
RMDSpaceModel >> westOfOffset: anInteger do: aBlock [

	(self xIndexFromOffset: anInteger) > 1 ifTrue: [ aBlock value: anInteger - xStep ]
]

{ #category : 'accessing-memory' }
RMDSpaceModel >> xIndexFromOffset: anInteger [

	^ anInteger // patchSize \\ xPatches + 1
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> xIndexFromX: aNumber [

	^ aNumber // patchLength + 1
]

{ #category : 'accessing-structure' }
RMDSpaceModel >> xPatches [

	^ xPatches
]

{ #category : 'accessing-structure' }
RMDSpaceModel >> xPatches: anInteger [

	xPatches := anInteger
]

{ #category : 'accessing-memory' }
RMDSpaceModel >> yIndexFromOffset: anInteger [

	^ anInteger // yStep + 1
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> yIndexFromY: aNumber [

	^ aNumber // patchLength + 1
]

{ #category : 'accessing-structure' }
RMDSpaceModel >> yPatches [

	^ yPatches
]

{ #category : 'accessing-structure' }
RMDSpaceModel >> yPatches: anInteger [

	yPatches := anInteger
]
