\name{getAdj}
\alias{getAdj}
\title{
Extract values adjusted for unwanted variation by RUVm
}
\description{
Extract values adjusted for unwanted variation by RUVm.
}
\usage{
getAdj(Y, fit)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Y}{
A matrix of M-values.
}
  \item{fit}{
The list \code{list} object produced by \code{RUVfit}.
}
}
\details{
This function extracts values adjusted for unwanted variation by RUVm. 
These values are ONLY intendeded to be used for visualisation purposes. 
It is NOT recommended that they are used for any further analysis.
}
\value{
An matrix of M-values.
}
\author{
Jovana Maksimovic \email{jovana.maksimovic@mcri.edu.au}
}
\seealso{
\code{\linkS4class{MArrayLM}}
}
\examples{
if(require(minfi) & require(minfiData) & require(limma)) {

# Get methylation data for a 2 group comparison
meth <- getMeth(MsetEx)
unmeth <- getUnmeth(MsetEx)
Mval <- log2((meth + 100)/(unmeth + 100))

group <- factor(pData(MsetEx)$Sample_Group, labels=c(0,1))
design <- model.matrix(~group)

# Perform initial analysis to empirically identify negative control features 
# when not known a priori
lFit <- lmFit(Mval,design)
lFit2 <- eBayes(lFit)
lTop <- topTable(lFit2,coef=2,num=Inf)

# The negative control features should *not* be associated with factor of interest
# but *should* be affected by unwanted variation 
ctl <- rownames(Mval) \%in\% rownames(lTop[lTop$adj.P.Val > 0.5,])

# Perform RUV adjustment and fit
fit <- RUVfit(Y=Mval, X=group, ctl=ctl)
fit2 <- RUVadj(Y=Mval, fit=fit)

# get adjusted values
Madj <- getAdj(Y=Mval,fit=fit)
}
}