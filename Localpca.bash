#vcf转换成bcf
bcftools convert -O b final-raw.indel5.biSNP.QUAL30.QD3.FS20.MQ55.SOR3.MQRS-5.RPRS-5.PASS.GQ10.popmiss.maxmiss0.15.AF0.05.10-3ClusterFilter.vcf.gz > mydata.bcf
bcftools index mydata.bcf
#使用1kb的连续窗口，将bcf、索引csi、sample_info.tsv放到data目录下，-i直接指定data目录
#sample_info.tsv长这样，制表符隔开
#ID	population
#AM-1	AM

./run_lostruct.R -i data -t bp -s 100000 -I data/sample_info.tsv 

#看一下生成的结果文件：
#生成的文件包括：
#config.json：run_lostruct.R的配置文件，也用于制作报告。
#chr1.pca.csv：解释的百分比变化和窗口的前两个特征值和特征向量，每行一个窗口。
#chr1.regions.csv ：窗口的位置，每行一个：染色体、第一个 SNP 位置、最后一个 SNP 位置。
#mds_coords.csv ：窗口的 MDS 坐标 - 文件名、窗口编号和 MDS 坐标。

ls lostruct_results/type_bp_size_100000_weights_none_jobid_269947/

#用以下命令，生成运行记录，将生成文件run_summary.html，可以在 Web 浏览器中查看该文件。

conda activate r4.3
cd /data01/wangyf/project2/CyprinusCarpio/15.pop/4.slide-window/3.local_pca/
R

library(usethis)
library(devtools)
library(data.table)
library(lostruct)
library(templater)

setwd("/data01/wangyf/project2/CyprinusCarpio/15.pop/4.slide-window/3.local_pca/")

templater::render_template("summarize_run.Rmd",output="lostruct_results/type_bp_size_100000_weights_none_jobid_406529/run_summary.html",change.rootdir=TRUE)

#将运行记录生成的每个文件进行存储
render_template(
        "summarize_run.Rmd",
        output="lostruct_results/type_bp_size_100000_weights_none_jobid_406529/run_summary.html",
        change.rootdir=TRUE,
        envir=environment())
		
#ls()查看变量
#head(corner.regions)
