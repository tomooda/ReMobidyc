Class {
	#name : 'RMDBackgroundColorRendererPresenter',
	#superclass : 'RMDRendererPresenter',
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'layout' }
RMDBackgroundColorRendererPresenter >> defaultLayout [

	<script: 'self new open'>
	<spec>
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 5;
				   spacing: 5;
				   add: 'Background' expand: false;
				   add: colorDropList width: 60)
		  expand: false
]

{ #category : 'accessing' }
RMDBackgroundColorRendererPresenter >> preferredHeight [
	^ self class inputTextHeight
]
