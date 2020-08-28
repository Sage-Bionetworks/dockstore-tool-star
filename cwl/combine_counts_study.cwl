$namespaces:
  s: https://schema.org/
arguments:
- prefix: --out_dir
  valueFrom: $(runtime.outdir)
baseCommand:
- combine_counts_study.R
class: CommandLineTool
cwlVersion: v1.0
doc: 'Combine individual sample count files into a gene x sample matrix file.

  '
hints:
- class: DockerRequirement
  dockerPull: sagebionetworks/dockstore-tool-star:1.0.1-fa3a687
id: combine-counts
inputs:
- id: read_counts
  inputBinding:
    position: 0
  label: Read count files to combine
  type: File[]
- default: gene
  doc: 'Prefix for output file (i.e., <prefix>_all_counts_matrix.txt).

    '
  id: output_prefix
  inputBinding:
    position: 1
    prefix: --out_prefix
  label: Output counts file prefix
  type: string
- default: ReadsPerGene.out.tab
  doc: 'Suffix to strip from sample filename [default %(default)s].

    '
  id: sample_suffix
  inputBinding:
    position: 2
    prefix: --sample_suffix
  label: Suffix to remove from filename
  type: string
- default: 2
  doc: '1-based index of counts column to select [default %(default)s].

    '
  id: column_number
  inputBinding:
    position: 4
    prefix: --col_num
  label: Counts column number
  type: int
label: Combine read counts across samples
outputs:
- doc: Combined counts matrix saved as tab-delimited text file.
  id: combined_counts
  label: Combined counts matrix
  outputBinding:
    glob: '*_all_counts_matrix.txt'
  type: File
requirements:
- class: InlineJavascriptRequirement
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
