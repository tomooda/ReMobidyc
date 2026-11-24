Class {
	#name : 'RMDPatchColorBrightnessRendererTest',
	#superclass : 'RMDRendererTest',
	#category : 'ReMobidyc-Visualization-Tests',
	#package : 'ReMobidyc-Visualization-Tests'
}

{ #category : 'accessing' }
RMDPatchColorBrightnessRendererTest >> renderer [

	^ RMDPatchColorBrightnessRenderer
		  color: Color green
		  brightness: 'my grass' asRMDExpression
		  between: '0 [kcal]' asRMDExpression
		  and: '10000 [kcal]' asRMDExpression
]
