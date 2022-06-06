cwlVersion: v1.1
class: CommandLineTool
baseCommand: mycmd
arguments:
  argument1:
    prefix: --c
    valueFrom: ''
    position: 3
inputs:
  s1:
    type: File
    inputBinding:
      prefix: -s
      position: 1
  s2:
    type: File
    inputBinding:
      prefix: -s
      position: 2
  o:
    type: File
    inputBinding:
      prefix: -o
      position: 4
  ref_genome:
    type: File
    inputBinding:
      prefix: ''
      position: 5
  nn:
    type: int
    inputBinding:
      prefix: --nn
      position: 6
outputs:
  output1:
    type: File
    outputBinding:
      glob: myout.txt
  mystdout:
    type: stdout
stdout: abc.txt
