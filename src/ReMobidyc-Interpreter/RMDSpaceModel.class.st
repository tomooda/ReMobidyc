Class {
	#name : 'RMDSpaceModel',
	#superclass : 'Object',
	#category : 'ReMobidyc-Interpreter-Space',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Space'
}

{ #category : 'accessing-geometry' }
RMDSpaceModel >> locationArea [

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

{ #category : 'accessing-memory' }
RMDSpaceModel >> offsetAtIndividual: anInteger definition: aRMDAgentDefinitionNode memory: aRMDMemory [

	^ self subclassResponsibility
]

{ #category : 'accessing-memory' }
RMDSpaceModel >> totalMemorySize [

	^ self subclassResponsibility
]
