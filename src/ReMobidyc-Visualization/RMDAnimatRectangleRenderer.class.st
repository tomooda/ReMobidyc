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
RMDAnimatRectangleRenderer >> renderAt: aPoint on: aRMDVisualizer [

	aRMDVisualizer drawRectangleAt: aPoint extent: self shapeSize color: self color
]
