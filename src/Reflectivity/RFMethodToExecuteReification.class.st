"
a message send at runtime has all the information to know which method will be called.

This reification uses lookupSelector: to calculate the method.
"
Class {
	#name : 'RFMethodToExecuteReification',
	#superclass : 'RFReification',
	#category : 'Reflectivity-Reifications',
	#package : 'Reflectivity',
	#tag : 'Reifications'
}

{ #category : 'plugin interface' }
RFMethodToExecuteReification class >> entities [
	^{RBMessageNode}
]

{ #category : 'plugin interface' }
RFMethodToExecuteReification class >> key [
	^#methodToExecute
]

{ #category : 'generate' }
RFMethodToExecuteReification >> genForRBMessageNode [
	^RBMessageNode
		receiver: (RBMessageNode receiver: (ASTVariableNode named: #RFReceiverReificationVar) selector: #class)
		selector: #lookupSelector:
		arguments: (ASTLiteralValueNode value: entity selector)
]

{ #category : 'preamble' }
RFMethodToExecuteReification >> preambleForMessage: aNode [
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
