\name{RUVfit}
\alias{RUVfit}
\title{
Remove unwanted variation when testing for differential methylation
}

\description{
Provides an interface similar to \code{\link{lmFit}} from \code{\link{limma}} to 
the \code{\link{RUV2}}, \code{\link{RUV4}}, \code{\link{RUVinv}} and 
\code{\link{RUVrinv}} functions from the \code{\link{ruv}} package, which 
facilitates the removal of unwanted variation in a differential methylation 
analysis. A set of negative control variables, as described in the references, 
must be specified.
}

\usage{
RUVfit(Y, X, ctl, Z = 1, k = NULL, method=c("inv", "rinv", "ruv4", "ruv2"), ...)
}

\arguments{
\item{Y}{
numeric \code{matrix} with rows corresponding to the features of interest such
as CpG sites and columns corresponding to samples or arrays.
}
\item{X}{
The factor(s) of interest. A m by p matrix, where m is the number of samples and 
p is the number of factors of interest. Very often p = 1. Factors and dataframes 
are also permissible, and converted to a matrix by \code{\link{design.matrix}}.
}
\item{ctl}{
logical vector, \code{length == nrow(Y)}. Features that are to be used as 
negative control variables are indicated as TRUE, all other features are FALSE.
}
\item{Z}{
Any additional covariates to include in the model, typically a m by q matrix. 
Factors and dataframes are also permissible, and converted to a matrix by 
\code{\link{design.matrix}}. Alternatively, may simply be 1 (the default) for an intercept 
term. May also be NULL.
}
\item{k}{
integer, required if \code{method} is "ruv2" or "ruv4". Indicates the number of
unwanted factors to use. Can be 0.
}
\item{method}{
character string, indicates which \code{\link{ruv}} method should be used.
} 
\item{...}{
additional arguments that can be passed to \code{\link{RUV2}}, \code{\link{RUV4}}, 
\code{\link{RUVinv}} and \code{\link{RUVrinv}}. See linked function documentation 
for details.
} 
}

\details{
This function depends on the \code{\link{ruv}} package and is used to 
estimate and adjust for unwanted variation in a differential methylation analysis.
Briefly, the unwanted factors \code{W} are estimated using negative control 
variables. \code{Y} is then regressed on the variables \code{X}, \code{Z}, 
and \code{W}. For methylation data, the analysis is performed on the M-values, 
defined as the log base 2 ratio of the methylated signal to the unmethylated 
signal.
}

\value{
A \code{list} containing:
\item{betahat}{The estimated coefficients of the factor(s) of interest.
A p by n matrix.
}
\item{sigma2}{Estimates of the features' variances. A vector of length n. 
}
\item{t}{t statistics for the factor(s) of interest. A p by n matrix.
}
\item{p}{P-values for the factor(s) of interest. A p by n matrix.
}
\item{Fstats}{F statistics for testing all of the factors in X simultaneously..
}
\item{Fpvals}{P-values for testing all of the factors in X simultaneously.
}
\item{multiplier}{The constant by which \code{sigma2} must be multiplied in order 
to get an estimate of the variance of \code{betahat}.
}
\item{df}{The number of residual degrees of freedom.
}
\item{W}{The estimated unwanted factors.
}
\item{alpha}{The estimated coefficients of W.
}
\item{byx}{The coefficients in a regression of Y on X (after both Y and X have 
been "adjusted" for Z).  Useful for projection plots.
}
\item{bwx}{The coefficients in a regression of W on X (after X has been 
"adjusted" for Z). Useful for projection plots.
}
\item{X}{\code{X}. Included for reference.
}
\item{k}{\code{k}. Included for reference.
}
\item{ctl}{\code{ctl}. Included for reference.
}
\item{Z}{\code{Z}. Included for reference.
}
\item{fullW0}{Can be used to speed up future calls of \code{RUVfit}.
}
\item{include.intercept}{\code{include.intercept}. Included for reference.
}
\item{method}{Character variable with value indicating which RUV method was used. 
Included for reference.
}
}
\references{
Gagnon-Bartsch JA, Speed TP. (2012). Using control genes to correct for unwanted 
variation in microarray data. \emph{Biostatistics}. \bold{13}(3), 539-52. 
Available at: \url{http://biostatistics.oxfordjournals.org/content/13/3/539.full}.
Gagnon-Bartsch, Jacob, and Speed. {2013}. Removing Unwanted Variation from High 
Dimensional Data with Negative Controls. Available at: 
\url{http://statistics.berkeley.edu/tech-reports/820}.
}
\seealso{
\code{\link{RUV2}}, \code{\link{RUV4}}, \code{\link{RUVinv}}, \code{\link{RUVrinv}}, 
\code{\link{topRUV}}
}
\author{
Jovana Maksimovic \email{jovana.maksimovic@mcri.edu.au}
}
\examples{
if(require(minfi) & require(minfiData) & require(limma)) {
# Get methylation data for a 2 group comparison
meth <- getMeth(MsetEx)
unmeth <- getUnmeth(MsetEx)
Mval <- log2((meth + 100)/(unmeth + 100))
group <- factor(pData(MsetEx)$Sample_Group)
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
# Look at table of top results
top <- topRUV(fit2)
}
}