Class {
	#name : 'RMDPatchColorScaleRenderer',
	#superclass : 'RMDPatchColorRenderer',
	#instVars : [
		'min',
		'max'
	],
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'testing' }
RMDPatchColorScaleRenderer class >> isAbstract [

	^ self == RMDPatchColorScaleRenderer
]

{ #category : 'comparing' }
RMDPatchColorScaleRenderer >> = anObject [

	^ super = anObject and: [ 
		  min = anObject min and: [ max = anObject max ] ]
]

{ #category : 'comparing' }
RMDPatchColorScaleRenderer >> hash [

	^ (super hash bitXor: min hash) bitXor: max hash
]

{ #category : 'initialization' }
RMDPatchColorScaleRenderer >> initialize [
	super initialize.
	min := 0.0.
	max := 1.0
]

{ #category : 'accessing' }
RMDPatchColorScaleRenderer >> max [
	^ max
]

{ #category : 'accessing' }
RMDPatchColorScaleRenderer >> max: aRMDLiteral [
	max := aRMDLiteral
]

{ #category : 'accessing' }
RMDPatchColorScaleRenderer >> min [
	^ min
]

{ #category : 'accessing' }
RMDPatchColorScaleRenderer >> min: aRMDLiteral [
	min := aRMDLiteral
]

{ #category : 'accessing' }
RMDPatchColorScaleRenderer >> valueForIndividual: anInteger interpreter: aRMDInterpreter [

	| patchDef value |
	patchDef := aRMDInterpreter simulationModel patchDefinition.
	aRMDInterpreter
		withObserverContextWithSubject: anInteger
		definition: patchDef
		do: [ value := expression evalIn: aRMDInterpreter ].
	^ value - min numeric / (max numeric - min numeric) min: 1.0 max: 0.0
]
