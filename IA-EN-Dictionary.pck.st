'From Cuis7.5 [latest update: #7262] on 6 June 2025 at 2:32:11 pm'!
'Description Enter a word in English or Interlingua and find the corresponding Interlingua or English usage. '!
!provides: 'IA-EN-Dictionary' 1 1!
SystemOrganization addCategory: #'IA-EN-Dictionary'!


!classDefinition: #IEDict category: #'IA-EN-Dictionary'!
Object subclass: #IEDict
	instanceVariableNames: ''
	classVariableNames: 'DictData'
	poolDictionaries: ''
	category: 'IA-EN-Dictionary'!
!classDefinition: 'IEDict class' category: #'IA-EN-Dictionary'!
IEDict class
	instanceVariableNames: ''!


!IEDict commentStamp: '<historical>' prior: 0!
I embody a specialized Dictionary of Interlingua<-->English.

Class intention
	I am not like a regular dictionary because I maintain my definitions 
	in an array of two element arrays #('interlingua definition' 'English definition'). 
	All definitions which contain a search match are returned.

Instance intention
      I am the model of an IEDictWindow
!

!IEDict class methodsFor: 'lookup' stamp: 'KenD 6/6/2025 14:22:20'!
englishContains: aString
	"Answer all definition pairs which contain aString looking in the English side"

	| matchStr |
	matchStr :=  ('*' , aString , '*' ) .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 2) ]! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 6/6/2025 14:22:47'!
englishStarts: aString
	"Answer all definition pairs which starts with aString looking in the English side"

	| matchStr |
	matchStr :=  aString , '*'  .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 2) ]! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 6/6/2025 14:21:42'!
interlinguaContains: aString
	"Answer all definition pairs which contain aString looking in the Interlingua side"

	| matchStr |
	matchStr :=  ('*' , aString , '*' ) .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 1) ]! !

!IEDict class methodsFor: 'lookup' stamp: 'KenD 6/6/2025 14:22:01'!
interlinguaStarts: aString
	"Answer all definition pairs which starts with aString looking in the Interlingua side"

	| matchStr |
	matchStr :=  aString , '*'  .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 1) ]! !

!IEDict class methodsFor: 'class initialization' stamp: 'KenD 6/6/2025 14:17:42'!
initialize
	"Read in my data"
"
	IEDict initialize.
"
	| curIndex aLine |
	DictData := Array new: 31034. "We know the exact size (wc -l iedict.txt) less 1"

	(self package fullFileName asFileEntry parent  // 'iedict.txt') readStreamDo: [ :fileStream |
		fileStream nextLine. "Skip initial comment line"
		curIndex := 1.
		aLine := fileStream nextLine. 
		[aLine isNil] whileFalse: [
			DictData at: curIndex 
				  put: ((aLine findBetweenSubStrs: ':') 
						collect: [:str| str withBlanksTrimmed]). 
			aLine := fileStream nextLine. 
			curIndex := 1 + curIndex.
		]
	] ! !
IEDict initialize!
