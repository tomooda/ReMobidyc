Class {
	#name : 'RMDPatchColorAlphaRendererPresenter',
	#superclass : 'RMDPatchColorRangeRendererPresenter',
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'layout' }
RMDPatchColorAlphaRendererPresenter class >> defaultLayout [
	<spec>
	^ SpBoxLayout newVertical
		borderWidth: 0;
		spacing: 0;
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: 'Patches' expand: false)
			height: self inputTextHeight;
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: '        ' expand: false;
				add: #colorDropList width: 60;
				add: ' with alpha = ' expand: false;
				add: #expressionField;
				add: '(' expand: false;
				add: #minField width: 100;
				add: '〜' expand: false;
				add: #maxField width: 100;
				add: ') ' expand: false)
			height: self inputTextHeight;
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: '        ' expand: false;
				add: #borderColorDropList width: 60;
				add: ' border lines of ' expand: false;
				add: #borderWidthField width: 40;
				add: ' pixels wide.' expand: false;
				yourself)
			height: self inputTextHeight
]

{ #category : 'accessing' }
RMDPatchColorAlphaRendererPresenter >> preferredHeight [
	^ self class inputTextHeight * 3
]
