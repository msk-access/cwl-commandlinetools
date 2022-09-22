# athena 

Athena is a tool to generate coverage statistics for NGS data, and combine these into an interactive HTML report. This gives both summary level and in depth information as to the coverage of the data, including various tables and plots to visualise the data. Athena can also optionally include plots visualising per-chromosome level coverage.

The general workflow for generating the statistics and report is as follows: 

+ Annotate each region of the bed file with the gene, exon and per base coverage data using annotate_bed.cwl
+ Generate per exon and per gene statistics using coverage_stats_single.cwl
+ Generate HTML coverage report with coverage_report_single.cwl
