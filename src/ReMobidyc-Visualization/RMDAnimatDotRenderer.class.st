Class {
	#name : 'RMDAnimatDotRenderer',
	#superclass : 'RMDAnimatShapeRenderer',
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'accessing' }
RMDAnimatDotRenderer >> name [
	^ 'dot renderer'
]

{ #category : 'printing' }
RMDAnimatDotRenderer >> printOn: aStream [

	aStream
		nextPutAll: animat;
		nextPutAll: ' -> '.
	shapeSize printOn: aStream.
	aStream nextPutAll: ' pixels '.
	self printColorOn: aStream.
	aStream nextPutAll: ' dot.'.
	aStream cr
]

{ #category : 'drawing' }
RMDAnimatDotRenderer >> renderIndividual: anInteger on: aRMDVisualizer [

	aRMDVisualizer
		drawRectangleExtent: self shapeSize
		color: self color
		forIndividual: anInteger
		definition: animatDefinition
]
