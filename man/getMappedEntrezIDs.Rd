\name{getMappedEntrezIDs}
\alias{getMappedEntrezIDs}
\title{
Get mapped Entrez Gene IDs from CpG probe names
}
\description{
Given a set of CpG probe names and optionally all the CpG sites tested, this function outputs a list containing the mapped Entrez Gene IDs as well as the numbers of probes per gene, and a vector indicating significance. 
}
\usage{
getMappedEntrezIDs(sig.cpg, all.cpg = NULL, array.type, anno = NULL)
}
\arguments{
  \item{sig.cpg}{
      character vector of significant CpG sites used for testing gene set enrichment
  }
  \item{all.cpg}{
      character vector of all CpG sites tested. Defaults to all CpG sites on the array.
  }
  \item{array.type}{
        the Illumina methylation array used. Options are "450K" or "EPIC".
  }
  \item{anno}{
        Optional. A \code{DataFrame} object containing the complete array annotation as
        generated by the \code{\link{minfi}} \code{\link{getAnnotation}} function. Speeds up 
        execution, if provided.
  }

}
\details{
This function is used by the gene set testing functions \code{gometh} and \code{gsameth}. It maps the significant CpG probe names to Entrez Gene IDs, as well as all the CpG sites tested. It also calculates the numbers of probes for gene.

Genes associated with each CpG site are obtained from the annotation package \code{IlluminaHumanMethylation450kanno.ilmn12.hg19} if the array type is "450K". For the EPIC array, the annotation package \code{IlluminaHumanMethylationEPICanno.ilm10b4.hg19} is used. To use a different annotation package, please supply it using the \code{anno} argument.
}
\value{
A list with the following elements
  \item{sig.eg}{
  	mapped Entrez Gene IDs for the significant probes
  }
  \item{universe}{
  	mapped Entrez Gene IDs for all probes on the array, or for all the CpG probes tested.
  }
  \item{freq}{
  	table output with numbers of probes associated with each gene
  }
  \item{de}{
  	a vector of ones and zeroes of the same length of universe indicating which genes in the universe are significantly differentially methylated.
  }
  \item{fract.counts}{
    a dataframe with 2 columns corresponding to the Entrez Gene IDS for the significant probes and the associated weight to account for multi-mapping probes.
  }
}
\seealso{
\code{\link{gometh},\link{gsameth}}
}
\author{
Belinda Phipson
}
\examples{
\dontrun{ # to avoid timeout on Bioconductor build
library(IlluminaHumanMethylation450kanno.ilmn12.hg19)
library(org.Hs.eg.db)
library(limma)
ann <- getAnnotation(IlluminaHumanMethylation450kanno.ilmn12.hg19)

# Randomly select 1000 CpGs to be significantly differentially methylated
sigcpgs <- sample(rownames(ann),1000,replace=FALSE)

# All CpG sites tested
allcpgs <- rownames(ann)

mappedEz <- getMappedEntrezIDs(sigcpgs,allcpgs,array.type="450K")
mappedEz$sig.eg[1:10]
mappedEz$universe[1:10]
mappedEz$freq[1:10]
mappedEz$de[1:10]
}
}
