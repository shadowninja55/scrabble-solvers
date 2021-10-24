load 'format/printf'

letters =: 'abcdefg'
valid =. (*./@e.)*.{{*./(+/x=/y)<:+/=/~y}}
words =: (#~>@(valid&letters&.>)) 'b' freads 'dictionary.txt'
scores =: 1 3 3 2 1 4 2 4 1 8 5 1 3 1 1 3 10 1 1 1 1 4 4 8 4 10
sorted =: (/:{{+/scores{~97-~a.i.y}}&.>) words
(('%d. %s'&printf)@;~&.> >:@|.@i.@#) sorted