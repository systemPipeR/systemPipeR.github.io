cwlVersion: v1.1
class: CommandLineTool
baseCommand: hisat2
arguments: []
inputs:
  S:
    type: File
    inputBinding:
      prefix: -S
  x:
    type: File
    inputBinding:
      prefix: -x
  k:
    type: int
    inputBinding:
      prefix: -k
  min-intronlen:
    type: int
    inputBinding:
      prefix: -min-intronlen
  max-intronlen:
    type: int
    inputBinding:
      prefix: -max-intronlen
  threads:
    type: int
    inputBinding:
      prefix: -threads
  U:
    type: File
    inputBinding:
      prefix: -U
  verbose:
    type: ''
    inputBinding:
      prefix: --verbose
outputs:
  output1:
    type: File
    outputBinding:
      glob: ./results/M1A.sam
