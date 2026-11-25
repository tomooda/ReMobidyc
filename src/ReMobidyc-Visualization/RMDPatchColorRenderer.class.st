Class {
	#name : 'RMDPatchColorRenderer',
	#superclass : 'RMDPatchExpressionRenderer',
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'testing' }
RMDPatchColorRenderer class >> isAbstract [

	^ self == RMDPatchColorRenderer
]

{ #category : 'accessing' }
RMDPatchColorRenderer >> colorFor: anInteger interpreter: aRMDInterpreter [

	^ self colorFrom: (self valueForIndividual: anInteger interpreter: aRMDInterpreter)
]

{ #category : 'accessing' }
RMDPatchColorRenderer >> colorFrom: aNumber [
	^ self subclassResponsibility 
]

{ #category : 'drawing' }
RMDPatchColorRenderer >> renderPatch: anInteger on: aRMDVisualizer [

	aRMDVisualizer drawPatch: anInteger color: (self colorFor: anInteger interpreter: aRMDVisualizer interpreter)
]
