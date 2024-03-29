\name{topVar}
\alias{topVar}
\title{
	Table of top-ranked differentially variable CpGs
}
\description{
	Extract a table of the top-ranked CpGs from a linear model fit after a differential variability analysis.	
}
\usage{
topVar(fit, coef = NULL, number = 10, sort = TRUE)
}
\arguments{
  \item{fit}{
	list containing a linear model fit produced by \code{varFit}. The fit object should be of class \code{MArrayLM}.
}
  \item{coef}{
	column number or column name specifying which coefficient of the linear model fit is of interest. It should be the same coefficient that the differential variability testing was performed on. Default is last column of fit object.
}
  \item{number}{
	maximum number of genes to list. Default is 10.
}
  \item{sort}{
	logical, default is TRUE. Sorts output according the P-value. FALSE will return results in same order as fit object. 
}
}
\details{
	This function summarises the results of a differential variability analysis performed with \code{varFit}. The p-values from the comparison of interest are adjusted using Benjamini and Hochberg's false discovery rate with the function \code{p.adjust}. The top ranked CpGs are selected by first ranking the adjusted p-values, then ranking the raw p-values. At this time no other sorting option is catered for.
}
\value{
	Produces a dataframe with rows corresponding to the top CpGs and the following columns:
	\item{genelist }{one or more columns of annotation for each CpG, if the gene information is available in \code{fit}}
	\item{AvgVar }{average of the absolute or squared Levene residuals across all samples}
	\item{DiffVar }{estimate of the difference in the Levene residuals corresponding to the comparison of interest}
	\item{t }{moderated t-statistic}
	\item{P.Value }{raw p-value}
	\item{Adj.P.Value }{adjusted p-value}
}
\references{
	Phipson, B., and Oshlack, A. (2014). A method for detecting differential variability in methylation data shows CpG islands are highly variably methylated in cancers. \emph{Genome Biology}, \bold{15}:465.

	Benjamini, Y., and Hochberg, Y. (1995). Controlling the false discovery rate: a practical and powerful approach to multiple testing. \emph{Journal of the Royal Statistical Society Series}, B, \bold{57}, 289-300.
}
\author{
	Belinda Phipson
}
\seealso{
	\code{varFit}, \code{p.adjust}
}
\examples{
# Randomly generate data for a 2 group problem with 100 CpG sites and 5 arrays in each group. 

y<-matrix(rnorm(1000),ncol=10)

group<-factor(rep(c(1,2),each=5))
design<-model.matrix(~group)

# Fit linear model for differential variability
vfit<-varFit(y,design)

# Look at top table of results

topVar(vfit,coef=2)

}

