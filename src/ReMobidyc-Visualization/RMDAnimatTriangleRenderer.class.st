Class {
	#name : 'RMDAnimatTriangleRenderer',
	#superclass : 'RMDAnimatShapeRenderer',
	#category : 'ReMobidyc-Visualization',
	#package : 'ReMobidyc-Visualization'
}

{ #category : 'accessing' }
RMDAnimatTriangleRenderer >> name [
	^ 'triangle renderer'
]

{ #category : 'printing' }
RMDAnimatTriangleRenderer >> printOn: aStream [

	aStream
		nextPutAll: animat;
		nextPutAll: ' -> '.
	shapeSize printOn: aStream.
	aStream nextPutAll: ' pixels '.
	self printColorOn: aStream.
	aStream nextPutAll: ' triangle.'.
	aStream cr
]

{ #category : 'drawing' }
RMDAnimatTriangleRenderer >> renderAt: aPoint on: aRMDVisualizer [

	aRMDVisualizer
		drawPolygon: ({
				 0.0.
				 (Float pi * 2.0 / 3.0).
				 (Float pi * -2.0 / 3.0) } collect: [ :theta | theta sin negated @ theta cos negated * self shapeSize / 2.0 + aPoint ])
		color: self color
]
