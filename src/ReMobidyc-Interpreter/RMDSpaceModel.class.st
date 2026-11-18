Class {
	#name : 'RMDSpaceModel',
	#superclass : 'Object',
	#category : 'ReMobidyc-Interpreter-Space',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Space'
}

{ #category : 'accessing-geometry' }
RMDSpaceModel >> dimension [

	^ self subclassResponsibility
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> directionOfOffset: anInteger fromIndividual: anotherInteger definition: aRMDAnimatDefinitionNode memory: aRMDMemory [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
RMDSpaceModel >> fromIndividual: anInteger definition: aRMDAnimatDefinitionNode memory: aRMDMemory withinRadius: range offsetsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> geometryFromOffset: anInteger [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
RMDSpaceModel >> neighborsFromOffset: anInteger do: aBlock [

	| argumentCount |
	argumentCount := aBlock argumentCount.
	argumentCount = 1 ifTrue: [ ^ self neighborsFromOffset: anInteger offsetsDo: aBlock ].
	argumentCount = 2 ifTrue: [ ^ self neighborsFromOffset: anInteger offsetsAndVectorsDo: aBlock ]
]

{ #category : 'enumerating' }
RMDSpaceModel >> neighborsFromOffset: anInteger offsetsAndVectorsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
RMDSpaceModel >> neighborsFromOffset: anInteger offsetsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing-structure' }
RMDSpaceModel >> numberOfPatches [

	^ self subclassResponsibility
]

{ #category : 'accessing-geometry' }
RMDSpaceModel >> patchInfoFromOffset: anInteger do: aBlock [

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

{ #category : 'enumerating' }
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
