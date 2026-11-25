Class {
	#name : 'RMDAnimatRectangleRenderer',
	#superclass : 'RMDAnimatShapeRenderer',
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'accessing' }
RMDAnimatRectangleRenderer >> name [
	^ 'rectangle renderer'
]

{ #category : 'printing' }
RMDAnimatRectangleRenderer >> printOn: aStream [

	aStream
		nextPutAll: animat;
		nextPutAll: ' -> '.
	shapeSize printOn: aStream.
	aStream nextPutAll: ' pixels '.
	self printColorOn: aStream.
	aStream nextPutAll: ' rectangle.'.
	aStream cr
]

{ #category : 'drawing' }
RMDAnimatRectangleRenderer >> renderIndividual: anInteger on: aRMDVisualizer [

	aRMDVisualizer
		drawRectangleExtent: self shapeSize
		color: self color
		forIndividual: anInteger
		definition: animatDefinition
]
