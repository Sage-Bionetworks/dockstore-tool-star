$namespaces:
  s: https://schema.org/
arguments:
- prefix: --outFileNamePrefix
  valueFrom: $(runtime.outdir)/$(inputs.output_dir_name)
baseCommand:
- STAR
- --runMode
- alignReads
class: CommandLineTool
cwlVersion: v1.0
doc: 'STAR: Spliced Transcripts Alignment to a Reference.

  https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf

  '
hints:
- class: DockerRequirement
  dockerPull: sagebionetworks/dockstore-tool-star:1.0.0
inputs:
- id: mate_1_fastq
  inputBinding:
    position: 1
    prefix: --readFilesIn
  type: File
- id: mate_2_fastq
  inputBinding:
    position: 2
  type: File?
- id: sjdbGTFfile
  doc: 'path to GTF annotation file to use for guiding alignments'
  inputBinding:
    prefix: --sjdbGTFfile
  type: File?
- id: alignEndsType
  doc: 'type of alignment to perform on read ends. Possible options include: "Local", "EndToEnd", "Extend5pOfRead1", or "Extend5pOfReads12" (https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)'
  inputBinding:
    prefix: --alignEndsType
  type: string?
  default: "Local"
- id: outFilterMismatchNmax
  doc: 'maximum number of mismatches per pair (https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)'
  inputBinding:
    prefix: --outFilterMismatchNmax
  type: int?
- id: outFilterMultimapScoreRange
  doc: 'the score range below the maximum score for multimapping alignments (https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)'
  inputBinding:
    prefix: --outFilterMultimapScoreRange
  type: int?
- id: outFilterMultimapNmax
  doc: 'max number of multiple alignments allowed for a read: if exceeded, the read is considered unmapped (https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)'
  inputBinding:
    prefix: --outFilterMultimapNmax
  type: int?
- id: outFilterScoreMinOverLread
  doc: 'alignment will be output only if its score is higher than or equal to this value, normalized to read length (sum of mates’lengths for paired-end reads) (https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)'
  inputBinding:
    prefix: --outFilterScoreMinOverLread
  type: int?
- id: outFilterMatchNminOverLread
  doc: 'alignment will be output only if the number of matched bases is higherthan or equal to this value, normalized to the read length (sum of mates’ lengths for paired-end reads)(https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)'
  inputBinding: 
    prefix: --outFilterMatchNminOverLread
  type: int? 
- id: outFilterMatchNmin
  doc: 'alignment will be output only if the number of matched bases is higherthan or equal to this value (https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)'
  inputBinding:
    prefix: --outFilterMatchNmin
  type: int?
- id: alignSJDBoverhangMin
  doc: 'minimum overhang (i.e. block size) for annotated (sjdb) splicedalignments (https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)'
  inputBinding:
    prefix: --alignSJDBoverhangMin
  type: int?
- id: alignIntronMax
  doc: 'maximum intron size, if 0, max intron size will be determined by(2ˆwinBinNbits)*winAnchorDistNbins (https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)'
  inputBinding:
    prefix: --alignIntronMax
  type: int?
- default: .
  doc: 'path to the directory where genome files are stored

    '
  id: genstr
  inputBinding:
    prefix: --genomeDir
  label: Reference genome directory
  type: string?
- id: genome_dir
  type: File[]
- doc: 'defines the number of threads to be used for genome generation, it has

    to be set to the number of available cores on the server node.

    '
  id: nthreads
  inputBinding:
    prefix: --runThreadN
  label: Number of threads
  type: int
- default: STAR
  doc: 'Name of the directory to write output files in

    '
  id: output_dir_name
  label: Output directory name
  type: string
- default:
  - BAM
  - SortedByCoordinate
  doc: "1st word: BAM: output BAM without sorting, SAM: output SAM without\nsorting,\
    \ None: no SAM/BAM output, 2nd, 3rd: Unsorted: standard unsorted,\nSortedByCoordinate:\
    \ sorted by coordinate. This option will allocate\nextra memory for sorting which\
    \ can be specified by \u2013limitBAMsortRAM\n"
  id: output_sam_type
  inputBinding:
    prefix: --outSAMtype
  label: Output reads SAM/BAM
  type: string[]
- default: Within
  doc: "1st word: None: no output, Within: output unmapped reads within the main\n\
    SAM file (i.e. Aligned.out.sam). 2nd word: KeepPairs: record unmapped\nmate for\
    \ each alignment, and, in case of unsorted output, keep it\nadjacent to its mapped\
    \ mate. Only a\u21B5ects multi-mapping reads.\n"
  id: output_sam_unmapped
  inputBinding:
    prefix: --outSAMunmapped
  label: Unmapped reads action
  type: string
- default: GeneCounts
  doc: 'types of quantification requested. -: none, TranscriptomeSAM: output

    SAM/BAM alignments to transcriptome into a separate file, GeneCounts:

    count reads per gene

    '
  id: quant_mode
  inputBinding:
    prefix: --quantMode
  label: Quantification method
  type: string
- default: Basic
  doc: 'STAR will perform the 1st pass mapping, then it will automatically

    extract junctions, insert them into the genome index, and, finally,

    re-map all reads in the 2nd mapping pass. This option can be used with

    annotations, which can be included either at the run-time, or at the

    genome generation step

    '
  id: two_pass_mode
  inputBinding:
    prefix: --twopassMode
  label: Two-pass mode option
  type: string
label: STAR spliced alignment
outputs:
- id: aligned_reads_sam
  label: Aligned reads SAM
  outputBinding:
    glob: '*bam'
  type: File
- id: reads_per_gene
  label: Reads per gene
  outputBinding:
    glob: '*ReadsPerGene.out.tab'
  type: File
- id: splice_junctions
  label: Splice junctions
  outputBinding:
    glob: '*SJ.out.tab'
  type: File
- id: logs
  label: STAR logs
  outputBinding:
    glob: '*Log.final.out'
  type: File
requirements:
  InitialWorkDirRequirement:
    listing:
    - $(inputs.genome_dir)
s:author:
- class: s:Person
  s:email: mailto:inutano@gmail.com
  s:identifier: http://orcid.org/0000-0003-3777-5945
  s:name: Tazro Ohta
s:contributor:
- class: s:Person
  s:email: mailto:william.poehlman@sagebase.org
  s:identifier: https://orcid.org/0000-0002-3659-9663
  s:name: William Poehlman
