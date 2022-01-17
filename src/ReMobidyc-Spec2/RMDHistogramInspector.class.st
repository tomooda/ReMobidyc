Class {
	#name : #RMDHistogramInspector,
	#superclass : #RMDSpeciesInspector,
	#instVars : [
		'visibleProperties',
		'chartPresenters'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #specs }
RMDHistogramInspector class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: '';
		  yourself
]

{ #category : #accessing }
RMDHistogramInspector >> chartHeight [
	^ 200
]

{ #category : #accessing }
RMDHistogramInspector >> chartWidth [
	^ 760
]

{ #category : #accessing }
RMDHistogramInspector >> chartWith: propertyDef values: values min: min max: max divisions: divisions [

	| counts maxCount font fontHeight chartWidth chartHeight form canvas xScale yScale minString maxString |
	counts := Array new: divisions + 2 withAll: 0.
	values do: [ :value | 
		| index |
		index := value - min * divisions // (max - min) + 2
			         min: divisions + 2
			         max: 1.
		counts at: index put: (counts at: index) + 1 ].
	maxCount := counts max.
	chartWidth := self chartWidth.
	chartHeight := self chartHeight.
	font := TextStyle defaultFont.
	fontHeight := font height.
	form := Form
		        extent: chartWidth @ (chartHeight + fontHeight)
		        depth: 32.
	canvas := form getCanvas.
	canvas fillColor: Color white.
	xScale := chartWidth asFloat / counts size.
	yScale := (chartHeight - fontHeight) asFloat / (maxCount * 1.1).
	minString := (min printShowingDecimalPlaces: 2) , ' ['
	             , propertyDef unit printString , ']'.
	maxString := (max printShowingDecimalPlaces: 2) , ' ['
	             , propertyDef unit printString , ']'.
	1 to: counts size do: [ :index | 
		| count left right top bottom countString |
		count := counts at: index.
		left := (index - 1 * xScale) rounded.
		right := (index * xScale) rounded.
		top := chartHeight - (count * yScale) rounded min: chartHeight - 1.
		bottom := chartHeight.
		countString := count printString.
		canvas
			frameAndFillRectangle: (left @ top corner: right @ bottom)
			fillColor: Color lightGray
			borderWidth: 1
			borderColor: Color black;
			drawString: countString
			at: left + right - (font widthOfString: countString) // 2
				@ (top - fontHeight)
			font: font
			color: Color black ].
	canvas
		drawString: minString
		at:
			((xScale - ((font widthOfString: minString) // 2)) rounded max: 0)
			@ chartHeight
		font: font
		color: Color black;
		drawString: maxString
		at:
			((xScale * (divisions + 1) - ((font widthOfString: maxString) // 2))
				 rounded min: chartWidth - (font widthOfString: maxString))
			@ chartHeight
		font: font
		color: Color black.


	^ form
]

{ #category : #private }
RMDHistogramInspector >> collapseButtonFor: propertyDef [

	^ self newButton
		  label: propertyDef printString;
		  icon: self expandedIcon;
		  action: [ 
			  visibleProperties
				  removeKey: propertyDef identifier
				  ifAbsent: [  ].
			  self
				  updateLayout;
				  updateObservation ]
]

{ #category : #private }
RMDHistogramInspector >> expandButtonFor: propertyDef values: values [

	^ self newButton
		  label: propertyDef printString;
		  icon: self collapsedIcon;
		  borderWidth: 0;
		  borderColor: Color transparent;
		  action: [ 
			  (self requestMinMaxDivisionsFor: propertyDef values: values) 
				  ifNotNil: [ :triple | 
					  visibleProperties at: propertyDef identifier put: triple.
					  self
						  updateLayout;
						  updateObservation ] ]
]

{ #category : #initialization }
RMDHistogramInspector >> initializePresenters [

	super initializePresenters.
	visibleProperties := Dictionary new
]

{ #category : #accessing }
RMDHistogramInspector >> newLayout [

	^ SpBoxLayout newVertical
]

{ #category : #private }
RMDHistogramInspector >> requestMinMaxDivisionsFor: propertyDef values: values [

	| min max divisions |
	min := values ifNotEmpty: #min ifEmpty: [ 0.0 ].
	max := values ifNotEmpty: #max ifEmpty: [ 0.0 ].
	(UIManager default
		 request: 'min [' , propertyDef unit printString , ']'
		 initialAnswer: min printString)
		ifNotNil: [ :str | min := Number readFrom: str ifFail: [ ^ nil ] ]
		ifNil: [ ^ nil ].
	(UIManager default
		 request: 'max [' , propertyDef unit printString , ']'
		 initialAnswer: max printString)
		ifNotNil: [ :str | max := Number readFrom: str ifFail: [ ^ nil ] ]
		ifNil: [ ^ nil ].
	min < max ifFalse: [ 
		UIManager default alert: 'max should be greater than min'.
		^ nil ].
	(UIManager default request: 'divisions' initialAnswer: '10')
		ifNotNil: [ :str | 
		divisions := Integer readFrom: str ifFail: [ ^ nil ] ]
		ifNil: [ ^ nil ].
	divisions > 0 ifFalse: [ 
		UIManager default alert: 'divisions should be greater than 0'.
		^ nil ].
	^ { 
		  min.
		  max.
		  divisions }
]

{ #category : #updating }
RMDHistogramInspector >> updateImage [

	self layout ifNotNil: [ 
		chartPresenters ifNil: [ self updateLayout ].
		self propertyValuesDo: [ :propertyValues | 
			propertyValues propertiesDo: [ :propertyDef :vals :stats | 
				visibleProperties
					at: propertyDef identifier
					ifPresent: [ :triple | 
						chartPresenters
							at: propertyDef identifier
							ifPresent: [ :presenter | 
								| form |
								form := self
									        chartWith: propertyDef
									        values: vals
									        min: triple first
									        max: triple second
									        divisions: triple third.
								presenter image: form ] ] ] ] ]
]

{ #category : #updating }
RMDHistogramInspector >> updateLayout [

	self layout ifNotNil: [ 
		| newLayout |
		chartPresenters := Dictionary new.
		newLayout := self newLayout.
		self propertyValuesDo: [ :propertyValues | 
			propertyValues propertiesDo: [ :propertyDef :vals :stats | 
				visibleProperties
					at: propertyDef identifier
					ifPresent: [ :triple | 
						| form presenter |
						newLayout add: (self collapseButtonFor: propertyDef) expand: false.
						form := self
							        chartWith: propertyDef
							        values: vals
							        min: triple first
							        max: triple second
							        divisions: triple third.
						presenter := self newImage.
						presenter image: form.
						chartPresenters at: propertyDef identifier put: presenter.
						newLayout add: presenter height: form height ]
					ifAbsent: [ 
						newLayout
							add: (self expandButtonFor: propertyDef values: vals)
							expand: false ] ] ].
		self layout: newLayout ]
]

{ #category : #updating }
RMDHistogramInspector >> updateObservation [
	self updateImage.
	self changed
]