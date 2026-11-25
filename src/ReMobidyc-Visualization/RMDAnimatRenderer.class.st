Class {
	#name : 'RMDAnimatRenderer',
	#superclass : 'RMDRenderer',
	#instVars : [
		'animat',
		'animatDefinition'
	],
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'testing' }
RMDAnimatRenderer class >> isAbstract [

	^ self == RMDAnimatRenderer
]

{ #category : 'instance creation' }
RMDAnimatRenderer class >> on: aString [
	^ self new
		animat: aString;
		yourself
]

{ #category : 'comparing' }
RMDAnimatRenderer >> = anObject [

	^ super = anObject and: [ animat = anObject animat ]
]

{ #category : 'accessing' }
RMDAnimatRenderer >> animat [
	^ animat
]

{ #category : 'accessing' }
RMDAnimatRenderer >> animat: aString [
	animat := aString
]

{ #category : 'comparing' }
RMDAnimatRenderer >> hash [

	^ super hash bitXor: animat hash
]

{ #category : 'initialization' }
RMDAnimatRenderer >> initializeWith: aRMDInterpreter [

	animatDefinition := animat isString
		                    ifTrue: [ aRMDInterpreter simulationModel animatDefinitionAt: animat ifAbsent: [ nil ] ]
		                    ifFalse: [ animat ]
]

{ #category : 'testing' }
RMDAnimatRenderer >> isAnimatRendererFor: aString [
	^ animat = aString
]

{ #category : 'rewriting' }
RMDAnimatRenderer >> renameAnimat: aString to: anotherString [

	super renameAnimat: aString to: anotherString.
	animat = aString ifTrue: [ animat := anotherString ]
]

{ #category : 'drawing' }
RMDAnimatRenderer >> renderIndividual: anInteger on: aRMDVisualizer [

	^ self subclassResponsibility
]

{ #category : 'drawing' }
RMDAnimatRenderer >> renderOn: aRMDVisualization [

	aRMDVisualization interpreter
		individualsOf: animatDefinition
		do: [ :individual | self renderIndividual: individual on: aRMDVisualization ]
]
