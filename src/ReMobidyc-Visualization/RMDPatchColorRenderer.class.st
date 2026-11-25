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
RMDPatchColorRenderer >> renderPatch: anInteger at: aPoint on: aRMDVisualization with: aRMDInterpreter [

	aRMDVisualization
		drawRectangle: (Rectangle center: aPoint extent: patchLength asPoint)
		color: (self colorFor: anInteger interpreter: aRMDInterpreter)
]
