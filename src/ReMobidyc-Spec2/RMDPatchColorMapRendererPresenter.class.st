Class {
	#name : 'RMDPatchColorMapRendererPresenter',
	#superclass : 'RMDPatchExpressionRendererPresenter',
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'layout' }
RMDPatchColorMapRendererPresenter >> defaultLayout [

	<script: 'self new open'>
	<spec>
	^ SpBoxLayout newVertical
		  borderWidth: 0;
		  spacing: 0;
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 5;
				   spacing: 5;
				   add: 'Patches' asPresenter expand: false)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 0;
				   spacing: 0;
				   add: '        ' asPresenter expand: false;
				   add: colorDropList width: 60;
				   yourself)
		  expand: false
]

{ #category : 'initialization' }
RMDPatchColorMapRendererPresenter >> initializePresenters [
	super initializePresenters.
	self whenBuiltDo: [ self updateSpec ]
]

{ #category : 'accessing' }
RMDPatchColorMapRendererPresenter >> preferredHeight [
	^ (renderer numberOfMinAndColors + 3) * self class inputTextHeight
]

{ #category : 'accessing' }
RMDPatchColorMapRendererPresenter >> rendererChanged [
	super rendererChanged.
	self updateSpec
]

{ #category : 'updating' }
RMDPatchColorMapRendererPresenter >> updateSpec [

	| theLayout |
	layout ifNil: [ ^ self ].
	theLayout := layout presenters second.
	renderer ifNotNil: [
			renderer minAndColorEditorsDo: [ :presenter |
					theLayout add: presenter height: presenter preferredHeight.
					presenter whenChangedSend: #valueChanged to: self ] ]
]
