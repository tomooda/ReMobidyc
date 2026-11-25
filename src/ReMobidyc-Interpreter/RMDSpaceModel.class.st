Class {
	#name : 'RMDSpaceModel',
	#superclass : 'Object',
	#category : 'ReMobidyc-Interpreter-Space',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Space'
}

{ #category : 'accessing-geometry' }
RMDSpaceModel >> centroidFromPatchOffset: anInteger do: aBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> dimension [

	^ self subclassResponsibility
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> directionOfPatchOffset: anInteger fromIndividual: anotherInteger definition: aRMDAnimatDefinitionNode memory: aRMDMemory [

	^ self subclassResponsibility
]

{ #category : 'enumerating-geometry' }
RMDSpaceModel >> fromIndividual: anInteger definition: aRMDAnimatDefinitionNode memory: aRMDMemory withinRadius: range patchOffsetsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> geometryFromPatchOffset: anInteger [

	^ self subclassResponsibility
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> geometryOfWorld [

	^ self subclassResponsibility
]

{ #category : 'testing' }
RMDSpaceModel >> is2dSpace [

	^ false
]

{ #category : 'enumerating-structure' }
RMDSpaceModel >> neighborsFromOffset: anInteger do: aBlock [

	| argumentCount |
	argumentCount := aBlock argumentCount.
	argumentCount = 1 ifTrue: [ ^ self neighborsFromPatchOffset: anInteger patchOffsetsDo: aBlock ].
	argumentCount = 2 ifTrue: [ ^ self neighborsFromPatchOffset: anInteger patchOffsetsAndVectorsDo: aBlock ]
]

{ #category : 'enumerating-structure' }
RMDSpaceModel >> neighborsFromPatchOffset: anInteger patchOffsetsAndVectorsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'enumerating-structure' }
RMDSpaceModel >> neighborsFromPatchOffset: anInteger patchOffsetsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing-structure' }
RMDSpaceModel >> numberOfPatches [

	^ self subclassResponsibility
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> patchInfoFromPatchOffset: anInteger do: aBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> patchInfoKeysDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> patchLength [

	^ self subclassResponsibility
]

{ #category : 'accessing-memory' }
RMDSpaceModel >> patchOffsetAtIndividual: anInteger definition: aRMDAgentDefinitionNode memory: aRMDMemory [

	^ self subclassResponsibility
]

{ #category : 'enumerating-geometry' }
RMDSpaceModel >> patchOffsetsAndCentroidsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'enumerating-memory' }
RMDSpaceModel >> patchOffsetsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> patchSize [

	^ self subclassResponsibility
]

{ #category : 'accessing-memory' }
RMDSpaceModel >> totalMemorySize [

	^ self subclassResponsibility
]

{ #category : 'class access' }
RMDSpaceModel >> visualizerClass [

	^ self subclassResponsibility
]
