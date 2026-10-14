Class {
	#name : 'RMDPatchColorAlphaRendererPresenter',
	#superclass : 'RMDPatchColorRangeRendererPresenter',
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'layout' }
RMDPatchColorAlphaRendererPresenter >> defaultLayout [

	<script: 'self new open'>
	<spec>
	^ SpBoxLayout newVertical
		  borderWidth: 0;
		  spacing: 0;
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 5;
				   spacing: 5;
				   add: 'Patches' expand: false)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 5;
				   spacing: 5;
				   add: '        ' asPresenter expand: false;
				   add: colorDropList width: 60;
				   add: ' with alpha = ' asPresenter expand: false;
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
RMDPatchColorAlphaRendererPresenter >> preferredHeight [
	^ self class inputTextHeight * 3
]
