Ethan Thibault
BIO 381
02.14.2018
Homework 5

## Problems:
### One
#### Starting
First String    Second      1.22      3.4
Second          More Text   1.555555  2.2220
Third           x           3         124
#### Regular Expression
`\s{2,}`
`,`
#### Final
First String,Second,1.2,3.4
Second,More Text,1.55555,2.2220
Third,x3,124

### Two
#### Starting
Ballif, Bryan, University of Vermont
Ellison, Aaron, Harvard Forest
Record, Sydne, Bryn Mawr
#### Regular Expression
`(\w*),\s(\w*),\s(.*)`
`\2 \1 (\3)`
#### Final
Bryan Ballif (University of Vermont)
Aaron Ellison (Harvard Forest)
Sydne Record (Bryn Mawr)

### Three-one
#### Starting
0001 Georgia Horseshoe.mp3 0002 Billy In The Lowground.mp3 0003 Cherokee Shuffle.mp3 0004 Walking Cane.mp3
#### Regular Expression
`\s(\d{4})`
`\n\1`
#### Final
0001 Georgia Horseshoe.mp3
0002 Billy In The Lowground.mp3
0003 Cherokee Shuffle.mp3
0004 Walking Cane.mp3

### Three-two
#### Starting
0001 Georgia Horseshoe.mp3
0002 Billy In The Lowground.mp3
0003 Cherokee Shuffle.mp3
0004 Walking Cane.mp3
#### Regular Expression
`(\d{4})\s(.*)(\.mp3)`
`\2_\1\3`
#### Final
Georgia Horseshoe_0001.mp3
Billy In The Lowground_0002.mp3
Cherokee Shuffle_0003.mp3
Walking Cane_0004.mp3

### Four-one
#### Starting
Camponotus,pennsylvanicus,10.2,44
Camponotus,herculeanus,10.5,3
Myrmica,punctiventris,12.2,4
Lasius,neoniger,3.3,55
#### Regular Expression
`(\w)\w*,(\w*,)\d*\.\d*,(\d*)`
`\1_\2\3`
#### Final
C_pennsylvanicus,44
C_herculeanus,3
M_punctiventris,4
L_neoniger,55

### Four-two
#### Starting
Camponotus,pennsylvanicus,10.2,44
Camponotus,herculeanus,10.5,3
Myrmica,punctiventris,12.2,4
Lasius,neoniger,3.3,55
#### Regular Expression
`(\w)\w*,(\w{4})\w*,\d*\.\d*,(\d*)`
`\1_\2,\3`
#### Final
C_penn,44
C_herc,3
M_punc,4
L_neon,55