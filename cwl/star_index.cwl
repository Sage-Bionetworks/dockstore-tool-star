$namespaces:
  s: https://schema.org/
s:author:
  - class: s:Person
    s:identifier: http://orcid.org/0000-0003-3777-5945
    s:email: mailto:inutano@gmail.com
    s:name: Tazro Ohta
s:contributor:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-3659-9663
    s:email: mailto:william.poehlman@sagebase.org
    s:name: William Poehlman
arguments:
- prefix: --genomeDir
  valueFrom: $(inputs.genstr)
baseCommand:
- STAR
- --runMode
- genomeGenerate
class: CommandLineTool
cwlVersion: v1.0
doc: 'Generate genome indexes for STAR.


  STAR: Spliced Transcripts Alignment to a Reference.

  https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf

  '
hints:
- class: DockerRequirement
  dockerPull: sagebionetworks/dockstore-tool-star:0.0.2
inputs:
- doc: 'defines the number of threads to be used for genome generation, it has

    to be set to the number of available cores on the server node.

    '
  id: nthreads
  inputBinding:
    prefix: --runThreadN
  label: Number of threads
  type: int
- doc: 'specified one or more FASTA files with the genome reference sequences.

    Multiple reference sequences (henceforth called chromosomes) are allowed

    for each fasta file. You can rename the chromosomes names in the

    chrName.txt keeping the order of the chromo- somes in the file: the

    names from this file will be used in all output alignment files (such as

    .sam). The tabs are not allowed in chromosomes names, and spaces are not

    recommended.

    '
  id: genome_fastas
  inputBinding:
    prefix: --genomeFastaFiles
  label: Genome sequence FASTAs
  type: File
- doc: 'specifies the path to the file with annotated transcripts in the

    standard GTF format. STAR will extract splice junctions from this file

    and use them to greatly improve accuracy of the mapping. While this is

    optional, and STAR can be run without annotations, using annotations is

    highly recommended whenever they are available. Starting from 2.4.1a,

    the annotations can also be included on the fly at the mapping step.

    '
  id: genemodel_gtf
  inputBinding:
    prefix: --sjdbGTFfile
  label: Gene model GTF
  type: File
- default: 100
  doc: 'specifies the length of the genomic sequence around the annotated

    junction to be used in constructing the splice junctions database.

    Ideally, this length should be equal to the ReadLength-1, where

    ReadLength is the length of the reads. For instance, for Illumina 2x100b

    paired-end reads, the ideal value is 100-1=99. In case of reads of

    varying length, the ideal value is max(ReadLength)-1. In most cases, the

    default value of 100 will work as well as the ideal value

    '
  id: sjdb_overhang
  inputBinding:
    prefix: --sjdbOverhang
  label: Splice junction overhang
  type: int
- default: .
  id: genstr
  type: string?
- default: 14
  doc: 'length of the pre-indexing string used by STAR. Lower this value if you are

    using a very small referene genome or you need to generate smaller outputs

    '
  id: salength
  inputBinding:
    prefix: --genomeSAindexNbases
  type: int
- default: '150000000000'
  doc: 'This parameter sets the maxiumum amount of RAM

    that STAR will use

    '
  id: memory_limit
  inputBinding:
    prefix: --limitGenomeGenerateRAM
  label: memory limit for STAR
  type: string?
label: STAR genomeGenerate
outputs:
- id: genome_dir
  label: Reference genome directory
  outputBinding:
    glob: '*'
  type: File[]
requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
