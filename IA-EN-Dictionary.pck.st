'From Cuis7.0 [latest update: #6454] on 26 June 2024 at 12:43:28 pm'!
'Description '!
!provides: 'IA-EN-Dictionary' 1 0!
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
I embody a specialized Dictionary of Interlingua->English.

Class intention
	I am not like a regular dictionary because I maintain my definitions in an array of two element
	arrays #('interlingua definition' 'English definition').  All definitions which contain a search match
	are returned.

Instance intention
      I am the model of an IEDictWindow


WORKSPACE:

IEDict initialize.

IEDict interlinguaContains: 'provider'.
IEDict interlinguaStarts: 'provider'.
IEDict interlinguaStarts: 'omni'.
IEDict englishContains: 'day'.
IEDict englishStarts: 'day'.

IEDictWindow open. "-> opens a new IEDictWindow"!
