Class {
	#name : 'RMDPatchColorBrightnessRendererPresenter',
	#superclass : 'RMDPatchColorRangeRendererPresenter',
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'layout' }
RMDPatchColorBrightnessRendererPresenter class >> defaultLayout [
	<spec>
	^ SpBoxLayout newVertical
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
				add: ' with brightness = ' expand: false;
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
RMDPatchColorBrightnessRendererPresenter >> preferredHeight [
	^ self class inputTextHeight * 3
]
