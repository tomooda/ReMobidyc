Class {
	#name : 'RMDPatchColorAlphaRendererTest',
	#superclass : 'RMDRendererTest',
	#category : 'ReMobidyc-Visualization-Tests',
	#package : 'ReMobidyc-Visualization-Tests'
}

{ #category : 'accessing' }
RMDPatchColorAlphaRendererTest >> renderer [

	^ RMDPatchColorAlphaRenderer
		  color: Color green
		  alpha: 'my grass' asRMDExpression
		  between: '0 [kcal]' asRMDExpression
		  and: '10000 [kcal]' asRMDExpression
]
