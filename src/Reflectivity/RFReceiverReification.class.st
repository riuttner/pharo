"
I reify the receiver of a Message or a method
"
Class {
	#name : 'RFReceiverReification',
	#superclass : 'RFReification',
	#category : 'Reflectivity-Reifications',
	#package : 'Reflectivity',
	#tag : 'Reifications'
}

{ #category : 'plugin interface' }
RFReceiverReification class >> entities [
	^{RBMethodNode. RBMessageNode}
]

{ #category : 'plugin interface' }
RFReceiverReification class >> key [
	^#receiver
]

{ #category : 'generate' }
RFReceiverReification >> genForRBMessageNode [
	^ASTVariableNode named: #RFReceiverReificationVar
]

{ #category : 'generate' }
RFReceiverReification >> genForRBMethodNode [
	^ASTVariableNode selfNode
]

{ #category : 'preamble' }
RFReceiverReification >> preambleForMessage: aNode [
	| preamble |
	preamble := OrderedCollection new.

	(1 to: aNode numArgs) reverseWithIndexDo: [:each :index |
			| name |
			name := 'RFArg', index asString, 'RFReification'.
			preamble add:  (RFStorePopIntoTempNode named: name).
	].
	preamble
		add: (RFStoreIntoTempNode named: #RFReceiverReificationVar).
		(1 to: aNode numArgs) withIndexDo: [:each :index |
			| name |
			name := 'RFArg', index asString, 'RFReification'.
			preamble add:  (ASTVariableNode named: name).
	].

	^ preamble
]
