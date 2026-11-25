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
RMDAnimatDotRenderer >> renderAt: aPoint on: aRMDVisualizer [

	aRMDVisualizer drawRectangleAt: aPoint extent: self shapeSize color: self color
]
