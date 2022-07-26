Class {
	#name : #RMDAnimatTriangleRendererPresenter,
	#superclass : #RMDAnimatShapeRendererPresenter,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDAnimatTriangleRendererPresenter class >> defaultLayout [
	<spec>
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: #colorDropList width: 60;
				add: ' triangle of ' expand: false;
				add: #shapeSizeField width: 40;
				add: ' pixels' expand: false;
				yourself)
		height: self inputTextHeight
]