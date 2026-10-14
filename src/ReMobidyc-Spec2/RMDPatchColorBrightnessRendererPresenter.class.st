Class {
	#name : 'RMDPatchColorBrightnessRendererPresenter',
	#superclass : 'RMDPatchColorRangeRendererPresenter',
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'layout' }
RMDPatchColorBrightnessRendererPresenter >> defaultLayout [

	<script: 'self new open'>
	<spec>
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 5;
				   spacing: 5;
				   add: 'Patches' asPresenter expand: false)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 5;
				   spacing: 5;
				   add: '        ' asPresenter expand: false;
				   add: colorDropList width: 60;
				   add: ' with brightness = ' asPresenter expand: false;
				   add: expressionField;
				   add: '(' asPresenter expand: false;
				   add: minField width: 100;
				   add: '〜' asPresenter expand: false;
				   add: maxField width: 100;
				   add: ') ' asPresenter expand: false)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 5;
				   spacing: 5;
				   add: '        ' asPresenter expand: false;
				   add: borderColorDropList width: 60;
				   add: ' border lines of ' asPresenter expand: false;
				   add: borderWidthField width: 40;
				   add: ' pixels wide.' asPresenter expand: false;
				   yourself)
		  expand: false
]

{ #category : 'accessing' }
RMDPatchColorBrightnessRendererPresenter >> preferredHeight [
	^ self class inputTextHeight * 3
]
